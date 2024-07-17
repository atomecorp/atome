# frozen_string_literal: true

# server utils to handle eDen Db

class EDen

  class << self

    def db_access
      Database.db_access
    end

    def email_exist(data, message_id, ws)

      mail = data["email"]
      puts "mail : #{mail}"
      db = db_access
      puts "db : #{db}"
      user_table = db[:user]
      puts "user_table : #{user_table}"
      sanitized_email = sanitize_email(mail)
      puts "sanitized_email : #{sanitized_email}"
      user = user_table.where(email: sanitized_email).first
      puts "user : #{user}"
      # build the answer telling if email exist or not
      email_exists_response = !user.nil?
      puts "email_exists_response : #{email_exists_response}"
      # response return
      { data: { email_exist: email_exists_response }, message_id: message_id }
    end

    def terminal(data, message_id, ws)
      puts "terminal message  test : #{data}"
      { data: { message: `#{data}` }, message_id: message_id }
    end

    def metadata(msg, pid, message_id, ws)

      path = msg[:output_file]
      data = msg[:data]
      if msg[:read]
        command = "ffprobe -v error -show_entries format_tags=comment -of default=noprint_wrappers=1:nokey=1 #{path.shellescape}"

        Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
          if wait_thr.value.success?
            output = stdout.read
            puts "Metadata for #{path}:"
            puts output
          else
            puts "Error reading metadata: #{stderr.read}"
          end
        end
      else
        custom_data = data.to_json
        comment_metadata = "-metadata comment=#{custom_data.shellescape}"

        temp_output_file = "./temp_#{File.basename(path)}"
        ffmpeg_cmd = "ffmpeg -i #{path.shellescape} #{comment_metadata} -codec copy #{temp_output_file.shellescape}"

        Open3.popen3(ffmpeg_cmd) do |stdin, stdout, stderr, wait_thr|
          if wait_thr.value.success?
            FileUtils.mv(temp_output_file, path, force: true)
            puts "Metadata successfully added to #{path}"
          else
            puts "Error: #{stderr.read}"
          end
        end
      end

      ws.send({ :pid => pid, :return => msg, :message_id => message_id }.to_json)
    end

    def finished(msg, pid, message_id, ws)


      # write tag
      metadata(msg, pid, message_id, ws)

      # read tag
      msg[:read] = true
      metadata(msg, pid, message_id, ws)

      ws.send({ :pid => pid, :return => msg, :message_id => message_id }.to_json)
    end

    def stop_recording(params, message_id, ws)
      pid = params['pid']
      if pid
        begin
          Process.getpgid(pid) # Vérifier si le processus est toujours actif
          Process.kill("SIGINT", pid)
        rescue Errno::ESRCH # Le processus n'existe pas
          puts "Recording already stopped or PID not found."
        end
      else
        puts "No recording in progress.#{pid} : #{pid.class}"
      end
      { data: "process killed", message_id: message_id }

    end

    def record(data, message_id, ws)

      # # Command to start recording
      # # -c 1 indicates recording in mono
      # # rate 44.1k sets the sample rate to 44100 Hz
      # # trim 0 <duration> records audio for 'duration' seconds
      type = data['type']
      name = data['name']
      duration = data['duration']
      media = data['media']
      path = data['path']
      data = data['data']

      output_file = "#{path}/#{name}.#{type}"
      if media == 'audio'
        command = "rec -c 1 #{output_file} rate 44.1k trim 0 #{duration}"

        stdin, stdout, stderr, wait_thr = Open3.popen3(command)
        pid = wait_thr.pid # Sauvegarder le PID du processus ffmpeg
        msg = { output_file: output_file, media: :audio, record: :stop, data: data }
        Thread.new { wait_thr.join; finished(msg, pid, message_id, ws) }
      elsif media == 'video'
        resolution = "1280x720"
        framerate = "30"
        video_device_index = "0"
        audio_device_index = "1"
        command = "ffmpeg -f avfoundation -framerate #{framerate} -video_size #{resolution} " +
          "-i \"#{video_device_index}:#{audio_device_index}\" -t #{duration} " +
          "-pix_fmt yuv420p -vsync 1 -filter:a \"aresample=async=1\" #{output_file}"
        stdin, stdout, stderr, wait_thr = Open3.popen3(command)
        pid = wait_thr.pid # save the pid
        msg = { output_file: output_file, media: :video, record: :stop, data: data }
        Thread.new { wait_thr.join; finished(msg, pid, message_id, ws) }
      else
        #
      end

      { pid: pid, return: "path : #{path} record : #{media} received : duration #{duration} : name: #{name}, pid: #{pid}", message_id: message_id }
    end

    def authentication(data, message_id, ws)
      # database connexion :
      db = db_access
      # retrieving data from the 'identity' table
      identity_items = db[:user]
      # retrieving sent data
      user_email = data["particles"]["email"]
      user_pass = data["particles"]["password"]
      # database search
      user_exist = identity_items.where(email: user_email, password: user_pass).first
      if !user_exist
        { return: 'identifiants incorrects ou compte inexistant', message_id: message_id }
      else
        { return: "utilisateur loggé : #{user_exist.inspect}", mail_authorized: true, message_id: message_id }
      end
    end


    def localstorage(data, message_id, ws)
       { return: 'localstorage content received', authorized: true, message_id: message_id }

    end

    def historicize(data, message_id, ws)
       { return: 'item to historicize  received', authorized: true, message_id: message_id }

    end

    def init_db(_data, message_id, ws)
      unless File.exist?("eden.sqlite3")
        Sequel.connect("sqlite://eden.sqlite3")
      end
      { data: { message: 'database_ready' }, message_id: message_id }
    end

    def create_db_table(data, message_id, ws)
      table = data['table']
      type = data['type']
      Database.create_table(table, type)
      { data: { message: "table #{table} added" }, message_id: message_id }
    end

    def create_db_column(data, message_id, ws)
      table = data['table']
      column = data['column']
      type = data['type']
      Database.create_column(table, column, type)
      { data: { message: "column #{column} with type : #{type} added" }, message_id: message_id }
    end

    def query(data, message_id, ws)
      identity_table = db_access[data['table'].to_sym]
      result = identity_table.send(:all).send(:select)
      { data: { table: data['table'], infos: result }, message_id: message_id }
    end

    def account_creation(data, message_id, ws)
       { data: { message: "envoi de validation a #{data['email']}" }, message_id: message_id }
    end

    def insert(data, message_id, ws)
      table = data['table'].to_sym
      particles = data['particles']
      if db_access.table_exists?(table)
        schema = db_access.schema(table)
        insert_data = {}

        particles.each do |particle, value|
          particle_sym = particle.to_sym
          if schema.any? { |col_def| col_def.first == particle_sym }
            insert_data[particle_sym] = value
          else
            return { data: { message: "column not found: #{particle}" }, message_id: message_id }
          end
        end

        if insert_data.any?
          identity_table = db_access[table]
          identity_table.insert(insert_data)
          { data: { message: "Data inserted in table: #{table}" }, message_id: message_id }
        else
          { data: { message: "No valid columns provided" }, message_id: message_id }
        end
      else
        { data: { message: "table not found: #{table}" }, message_id: message_id }
      end
    end

    def file(data, message_id, ws)

      file_content = File.send(data['operation'], data['source'], data['value']).to_s
      file_content = file_content.gsub("'", "\"")

      file_content = file_content.gsub('#', '\x23')
      { data: "=> operation: #{data['operation']}, source: #{data['source']}, content: #{file_content}", message_id: message_id }
    end

    def safe_send(method_name, data, message_id, ws)
      method_sym = method_name.to_sym
      send(method_sym, data, message_id, ws)
    end
  end
end