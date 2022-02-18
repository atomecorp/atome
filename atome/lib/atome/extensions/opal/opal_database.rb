class Database
  def initialize(name)
    super()
    @db = `new DatabaseHelper(#{name})`
  end

  def create_table(table_name, content)
    `#{@db}.createTable(#{table_name},#{content})`
  end

  def create_user(content)
    `#{@db}.addUser(#{content.to_n})`
  end

  def create_document(content)
    `#{@db}.addDocument(#{content.to_n})`
  end

  def populate(table, fields)
    `#{@db}.addRow(#{table}, #{fields.to_n})`
  end

  def get_documents_by_user(user_id)
    `#{@db}.getDocumentsByUser(#{user_id})`
  end

  def get_documents_by_id(id)
    `#{@db}.getDocumentById(#{id})`
  end

  def update_documents(id, content)
    `#{@db}.updateDocumentById(#{id}, #{content})`
  end

  def delete_doc_by_id(id)
    `#{@db}.deleteDocumentById(#{id})`
  end

  def delete
    alert :poipoip
    `#{@db}.deleteDb()`
  end
end