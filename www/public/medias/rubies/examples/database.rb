c = circle({x: 9, y: 9, width: 36, height: 36, color: :green})
c2 = circle({x: 69, y: 9, width: 36, height: 36, color: :red})

c.touch do
  db = create({database: :atomeDB})
  create({table: {database: db, name: :user, content: "id, login, password, date"}})
  create({table: {database: db, name: :document, content: "id, content, user_id, date"}})
  create({user: {database: db, id: "a_87764", date: "2021-03-15", login: :regis, password: :alknx87978hjg}})
  create({user: {database: db, id: "a_87765", date: "2021-03-16", login: :jeezs, password: :oiuoih978hjg}})
  create({user: {database: db, id: "a_87766", date: "2021-02-06", login: :sylvain, password: :sdfsdfjg}})
  create({user: {database: db, id: "a_87767", date: "2021-02-02", login: :romain, password: :jfhdfg978hjg}})

  create({document: {database: db, id: "0", date: "2021-03-06", content: "circle({x: 300})", user_id: "a_87764"}})
  create({document: {database: db, id: "1", date: "2021-01-06", content: "text({x: 300})", user_id: "a_87769"}})
  create({document: {database: db, id: "2", date: "2021-02-12", content: "text({x: 300})", user_id: "a_87765"}})
  create({document: {database: db, id: "3", date: "2021-02-12", content: "image(:boat)", user_id: "a_87764"}})

  create({add: {database: db,type: :user,
                id: "a_87770", date: "2019-02-06", login: :benoit, password: :l554kjhkjsfdg }})
  JSUtils.get_documents_by_user(db, "a_87764")
  JSUtils.update_documents(db, "0", "big_car")
  JSUtils.get_documents_by_id(db, "0")
  JSUtils.delete_doc_by_id(db, "0")
  JSUtils.get_documents_by_id(db, "0")

end
c2.touch do
  JSUtils.delete_db("atomeDB")
end