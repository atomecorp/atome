c = circle({x: 9, y: 9, width: 36, height: 36, color: :green})
c2 = circle({x: 69, y: 9, width: 36, height: 36, color: :red})

c.touch do
  db = Database.new(:atomeDB)

  db.create_table(:user, "id, login, password, date")
  db.create_table(:document, "id, content, user_id, date")
  db.create_user({id: "a_87764", date: "2021-03-15", login: :regis, password: :alknx87978hjg})
  db.create_user({id: "a_87765", date: "2021-03-16", login: :jeezs, password: :oiuoih978hjg})
  db.create_user({id: "a_87766", date: "2021-02-06", login: :sylvain, password: :sdfsdfjg})
  db.create_user({id: "a_87767", date: "2021-02-02", login: :romain, password: :jfhdfg978hjg})

  db.create_document({id: "0", date: "2021-date: 03-06", content: "circle({x: 300})", user_id: "a_87764"})
  db.create_document({id: "1", date: "2021-01-06", content: "text({x: 300})", user_id: "a_87769"})
  db.create_document({id: "2", date: "2021-02-12", content: "text({x: 300})", user_id: "a_87765"})
  db.create_document({id: "3", date: "2021-02-12", content: "image(:boat)", user_id: "a_87764"})

  db.populate(:user, {id: "a_87770", date: "2019-02-06", login: :benoit, password: :l554kjhkjsfdg})
  db.get_documents_by_user("a_87764")
  db.update_documents("0", "big_car")
  db.get_documents_by_id("0")
  db.delete_doc_by_id("0")
  db.get_documents_by_id("0")

end
c2.touch do
  db.delete
end