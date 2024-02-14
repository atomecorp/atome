# frozen_string_literal: true

# server utils to handle eDen Db

class EDen
  class << self
    def db_access
      Database.db_access
    end

    def terminal(data, message_id)
      { data: { message: `#{data}` }, message_id: message_id }
    end

    def authorization(data, message_id)
      db = db_access
      security_items = db[:security]
      user_password = data["password"]
      user_exists = security_items.where(password: user_password).first

      if !user_exists
        { return: 'Password not found', message_id: message_id }
        # Ask to the user if he wants to subscribe
        # Send the basic template
      else
        { return: 'Password found, connected', message_id: message_id }
        # Send the user account template
      end
    end

    def authentication(data, message_id)
      # { data: { message: 'login received' }, message_id: message_id }
      db = db_access
      identity_items = db[:identity]
      user_email = data["email"]
      mail_exists = identity_items.where(email: user_email).first

      if !mail_exists
        { return: 'Email not found', message_id: message_id }
        # { return: user_email, message_id: message_id }
        # Ask to the user if he wants to subscribe
        # Send the basic template
      else
        { return: 'Email found, looking for pass', message_id: message_id }
        # Verify password
        # If password isn't ok, send error
        # If the password is ok, send the user account template
      end
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
      particle = data['particle'].to_sym
      data = data['data']
      if db_access.table_exists?(table)
        schema = db_access.schema(table)
        if schema.any? { |col_def| col_def.first == particle }
          identity_table = db_access[table.to_sym]
          identity_table.insert(particle => data)
          { data: { message: "column : #{particle}, in table : #{table}, updated with : #{data}" }, message_id: message_id }
        else
          { data: { message: "column not found: #{particle.class}" }, message_id: message_id }
        end
      else
        { data: { message: "table not found: #{table.class}" }, message_id: message_id }

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