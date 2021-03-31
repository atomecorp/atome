module JSUtils
  def self.create_database(database_name)
    `return new DatabaseHelper(#{database_name})`
  end

  def self.create_table(database, table_name, content)
    `#{database}.createTable(#{table_name},#{content})`
  end

  def self.create_user(database, content)
    `#{database}.addUser(#{content.to_n})`
  end

  def self.create_document(database, content)
    `#{database}.addDocument(#{content.to_n})`
  end

  def self.populate(database, table, fields)
    `#{database}.addRow(#{table}, #{fields.to_n})`
  end

  def self.get_documents_by_user(database, user_id)
    `#{database}.getDocumentsByUser(#{user_id})`
  end

  def self.get_documents_by_id(database, id)
    `#{database}.getDocumentById(#{id})`
  end

  def self.update_documents(database, id, content)
    `#{database}.updateDocumentById(#{id}, #{content})`
  end

  def self.delete_doc_by_id(database, id)
    `#{database}.deleteDocumentById(#{id})`
  end

  def self.delete_db(database)
    `#{database}.deleteDb()`
  end
end
