module JSUtils
  def self.create_database(params)
    `dbCreateDatabase(#{params})`
  end

  def self.create_table(database, table_name, content)
    `dbCreateTable(#{database},#{table_name},#{content})`
  end

  def self.create_user(database, content)
    `dbAddUser(#{database}, #{content.to_n})`
  end

  def self.create_document(database, content)
    `dbAddDocument(#{database}, #{content.to_n})`
  end

  def self.populate(database, type, content)
    `dbAdd(#{database},#{type}, #{content.to_n})`
  end

  def self.get_documents_by_user(user_id)
    `dbGetDocumentsByUser(#{user_id})`
  end

  def self.get_documents_by_id(id)
    `dbGetDocumentById(#{id})`
  end

  def self.update_documents(id, content)
    `dbUpdateDocumentById(#{id}, #{content})`
  end

  def self.delete_doc_by_id(id)
    `dbDeleteDocumentById(#{id})`
  end

  def self.delete_db(dbname)
    `deleteDB(#{dbname})`
  end

end