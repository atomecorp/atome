# frozen_string_literal: true

require('../server/IA')
# server utils to handle eDen Db
class EDen

  class << self

    def user_creation(value,  message_id, ws)
      { data: { message: "user creation message: #{value}" }, message_id: message_id }
    end

    def user_login(value,  message_id, ws)
      { data: { message: "user login message: #{value}" }, message_id: message_id }
    end

    def axion(data,  message_id, ws)
      query = data['prompt']
      user_key= data['user_key']
      send_AI_request(query, user_key)
      { data: { message: "read 'temp_script.rb' in the method infos" }, message_id: message_id }
    end

    def db_access
      Database.db_access
    end

    # def axion(data, message_id, ws)
    #
    #
    #   { data: { message: data }, message_id: message_id }
    # end

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
      return_string = `#{data}`
      { data: return_string, message_id: message_id }
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
          pid=pid .to_i
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
      puts "data =>>> #{data}"
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
    ###################### to test
    def update_by_aid(data, message_id, ws)
      table = data['table'].to_sym
      particles = data['particles']

      if db_access.table_exists?(table)
        schema = db_access.schema(table)
        update_data = {}
        aid_value = nil

        # Extraire la valeur de 'aid' du hash des particles
        aid_value = particles['aid'] if particles.key?('aid')

        # Vérifier si 'aid' existe et a une valeur
        if aid_value.nil?
          return { data: { message: "No 'aid' value provided for update" }, message_id: message_id }
        end

        # Construire le hash de données à mettre à jour
        particles.each do |particle, value|
          particle_sym = particle.to_sym
          if schema.any? { |col_def| col_def.first == particle_sym }
            update_data[particle_sym] = value
          else
            return { data: { message: "column not found: #{particle}" }, message_id: message_id }
          end
        end

        if update_data.any?
          identity_table = db_access[table]
          # Rechercher et mettre à jour l'enregistrement correspondant à l'aid
          updated_count = identity_table.where(aid: aid_value).update(update_data)

          if updated_count > 0
            { data: { message: "Data updated in table: #{table} for aid: #{aid_value}" }, message_id: message_id }
          else
            # Si aucune ligne n'est mise à jour (aid non trouvé), effectuer une insertion
            identity_table.insert(update_data)
            { data: { message: "No record found with aid: #{aid_value}, data inserted instead" }, message_id: message_id }
          end
        else
          { data: { message: "No valid columns provided" }, message_id: message_id }
        end
      else
        { data: { message: "table not found: #{table}" }, message_id: message_id }
      end
    end
    ###################### to test
    def get_filled_values_by_aid(table_name, aid_value)
      table = db_access[table_name.to_sym]

      # Récupérer l'enregistrement complet
      record = table.where(aid: aid_value).first

      # Si l'enregistrement n'existe pas, retourner nil ou un hash vide
      return nil if record.nil?

      # Filtrer les colonnes qui ont des valeurs non-null
      # (ou non vides selon vos critères)
      filled_values = record.reject do |key, value|
        value.nil? ||
          (value.is_a?(String) && value.empty?) ||
          (value.is_a?(Array) && value.empty?) ||
          (value.is_a?(Hash) && value.empty?)
      end

      filled_values
    end
    ###################### end
    def clear_column_by_aid(table_name, aid_value, column_name)
      table = db_access[table_name.to_sym]

      # Vérifier si la table existe
      unless db_access.table_exists?(table_name.to_sym)
        return { success: false, message: "Table not found: #{table_name}" }
      end

      # Vérifier si la colonne existe dans le schéma
      schema = db_access.schema(table_name.to_sym)
      unless schema.any? { |col_def| col_def.first == column_name.to_sym }
        return { success: false, message: "Column not found: #{column_name}" }
      end

      # Mettre à jour la colonne avec NULL
      update_count = table.where(aid: aid_value).update(column_name.to_sym => nil)

      if update_count > 0
        { success: true, message: "Column '#{column_name}' cleared for aid: #{aid_value}" }
      else
        { success: false, message: "No record found with aid: #{aid_value}" }
      end
    end
    ###################### end
    def file(data, message_id, ws)
      operation = data['operation']
      source = data['source']
      value = data['value']

      if %w[read delete].include?(operation) && !File.exist?(source)
        return { data: "file not found: #{source}", message_id: message_id }
      end

      begin
        file_content = case operation
                       when 'read'
                         File.read(source)
                       when 'write'
                         File.write(source['name'], source['content'])
                         'write successful'
                       when 'delete'
                         File.delete(source)
                         'delete successful'
                       else
                         'unsupported operation'
                       end

        file_content = file_content.gsub('#', '\x23')
        # file_content = file_content.gsub('~', '\x7E')
        file_content = JSON.dump(file_content)

        { data: file_content, message_id: message_id }

      rescue StandardError => e
        # Gestion des erreurs (ex : permissions, opération non réalisable)
        { data: "error during operation: #{operation}, source: #{source}, error: #{e.message}", message_id: message_id }
      end
    end
    # def file(data, message_id, ws)
    #   operation = data['operation']
    #   source = data['source']
    #   value = data['value']
    #
    #   # Check if the file exists for operations requiring its presence (e.g., read)
    #   #  if %w[read delete].include?(operation) && !File.exist?(source)
    #   if %w[read delete].include?(operation) && !File.exist?(source)
    #     return { data: "file not found: #{source}", message_id: message_id }
    #   end
    #
    #   if %w[write].include?(operation) #&& File.exist?(source)
    #     puts '##########\n'*21
    #     return { data: :ok, message_id: message_id }
    #   end
    #
    #   # run the task
    #   begin
    #     file_content = File.send(operation, source, value).to_s
    #     # Process the content to avoid problematic characters
    #     file_content = file_content.gsub('#', '\x23')
    #     file_content = JSON.dump(file_content)
    #     { data: file_content, message_id: message_id }
    #
    #   rescue StandardError => e
    #     # Error handling (example : permissions, operation not possible)
    #     { data: "error during operation: #{operation}, source: #{source}, error: #{e.message}", message_id: message_id }
    #   end
    # end

    def safe_send(method_name, data, message_id, ws)
      method_sym = method_name.to_sym
      send(method_sym, data, message_id, ws)
    end

  end


end