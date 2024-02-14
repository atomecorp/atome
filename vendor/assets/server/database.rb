# frozen_string_literal: true

# database handling for eDen Db
class Database
  class << self
    Sequel.extension :migration

    def db_access
      Sequel.connect("sqlite://eden.sqlite3")
    end

    def create_table(table_name)
      eden = Sequel.connect("sqlite://eden.sqlite3")
      unless eden.table_exists?(table_name)
        eden.create_table table_name.to_sym do
          primary_key "#{table_name}_id".to_sym
        end
      end
    end

    def create_column(table, column_name, type)
      eden = Sequel.connect("sqlite://eden.sqlite3")
      if eden.table_exists?(table)
        unless eden.schema(table).any? { |column| column.first == column_name }
          Sequel.migration do
            change do
              add_column table, column_name, type
            end
          end.apply(eden, :up)
        end
      end
    end
  end

end