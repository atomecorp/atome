# frozen_string_literal: true

# database handling for eDen Db
class Database
  class << self
    Sequel.extension :migration

    def db_access
      Sequel.connect("sqlite://eden.sqlite3")
    end

    def create_table(table_name, type)
      eden = Sequel.connect("sqlite://eden.sqlite3")
      type= case type

            when 'string'
              String
            when 'int'
              Integer
            when 'hash'
              JSON
            when 'date'
              DateTime
            else
              Integer
      end
      unless eden.table_exists?(table_name)
        eden.create_table table_name.to_sym do
          # primary_key "#{table_name}_id".to_sym
          column "#{table_name}_id".to_sym, type, primary_key: true
        end
      end
    end

    # def create_column(table, column_name, type)
    #   eden = Sequel.connect("sqlite://eden.sqlite3")
    #   if eden.table_exists?(table)
    #     unless eden.schema(table).any? { |column| column.first == column_name }
    #       Sequel.migration do
    #         change do
    #           add_column table, column_name, type
    #         end
    #       end.apply(eden, :up)
    #     end
    #   end
    # end
    def create_column(table, column_name, type)
      eden = Sequel.connect("sqlite://eden.sqlite3")
      if eden.table_exists?(table)
        begin
          Sequel.migration do
            change do
              add_column table, column_name, type unless eden.schema(table).any? { |column| column.first == column_name }
            end
          end.apply(eden, :up)
        rescue Sequel::DatabaseError => e
          puts "error adding column  : #{e.message}"
        end
      end
    end
  end

end