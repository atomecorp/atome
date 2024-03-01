# frozen_string_literal: true

# server utils to handle eDen Db

class EDen

  @@mail = nil
  @@pass = nil
  class << self

    @@mail = nil
    @@pass = nil

    def db_access
      Database.db_access
    end

    def terminal(data, message_id)
      { data: { message: `#{data}` }, message_id: message_id }
    end

    def sanitize_email(email)
      invalid_chars_pattern = /[^a-zA-Z0-9.-@]+/
      email.gsub(invalid_chars_pattern, '')
    end

    def authentication(data, message_id)
      # database connexion :
      db = db_access
      # retrieving data from the 'identity' table
      identity_items = db[:identity]
      # retrieving sent data
      user_email = data["email"]
      # data cleansing of superfluous characters
      sanitized_email = sanitize_email(user_email)
      # database search
      mail_exists = identity_items.where(email: sanitized_email).first

      if !mail_exists
        return { return: 'Email non trouvé, erreur', authorized: false, message_id: message_id }
      else
        @@mail = user_email
        if @@mail && @@pass
          @@mail = nil
          @@pass = nil
          return { return: 'logged', authorized: true, message_id: message_id }
          # Send the user account template
        else
          return { return: 'Email trouvé, cherche mdp', authorized: true, message_id: message_id }
        end
      end
    end

    def authorization(data, message_id)
      # database connexion :
      db = db_access
      # retrieving data from the 'security' table
      security_items = db[:security]
      # retrieving sent data
      user_password = data["password"]
      # database search
      user_exists = security_items.where(password: user_password).first

      if !user_exists
        puts "password recu : :#{user_password},   @@mail : #{  @@mail} , pass : #{  @@pass}"
        return { return: 'Password non trouvé, erreur', authorized: false, message_id: message_id }
      else
        @@pass = user_password
        if @@mail && @@pass
          # reset variables containing mail and password
          @@mail = nil
          @@pass = nil
          return { return: 'logged', authorized: true, message_id: message_id }
          # Send the user account template
        else
          return { return: 'Password trouvé, cherche mdp', authorized: true, message_id: message_id }
        end
      end
    end

    def localstorage(data, message_id)
      # return test
      # ws.send(return_message.to_json)
      return { return: 'localstorage content received', authorized: true, message_id: message_id }

    end

    def init_db(_data, message_id)
      unless File.exist?("eden.sqlite3")
        Sequel.connect("sqlite://eden.sqlite3")
      end
      { data: { message: 'database initialised' }, message_id: message_id }
    end

    def crate_db_table(data, message_id)
      table = data['table']
      Database.create_table(table)
      { data: { message: "table #{table} added" }, message_id: message_id }
    end

    def create_db_column(data, message_id)
      table = data['table']
      column = data['column']
      type = data['type']
      Database.create_column(table, column, type)
      { data: { message: "column #{column} with type : #{type} added" }, message_id: message_id }
    end

    def query(data, message_id)
      identity_table = db_access[data['table'].to_sym]
      result = identity_table.send(:all).send(:select)
      { data: { table: data['table'], infos: result }, message_id: message_id }
    end

    def insert(data, message_id)
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

    def file(data, message_id)

      file_content = File.send(data['operation'], data['source'], data['value']).to_s
      file_content = file_content.gsub("'", "\"")

      file_content = file_content.gsub('#', '\x23')
      { data: "=> operation: #{data['operation']}, source: #{data['source']}, content: #{file_content}", message_id: message_id }
    end

    def safe_send(method_name, data, message_id)
      method_sym = method_name.to_sym
      send(method_sym, data, message_id)
    end
  end
end