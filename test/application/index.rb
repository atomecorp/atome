# require './examples/attach'

new ({ particle: :protected }) do |params|
  puts "will add protectuon for =#{type} conidtion: #{params}"
end

# ###### history and server synchronisation
# b = box({id: :the_box})
# b.data(:canyouwritethis)
# b.rotate(33)
# b.rotate(88)
# b.rotate(99)
# b.rotate(12)
# b.rotate(6)
# b.data
# b.touch(true) do
#   b.data(:super)
#   b.data
#   alert b.history[:data]
# end
# alert b.history({operation: :write, id: :the_box, particle: :rotate})
# Universe.synchronised(507,:dbQKhb876HZggd87Hhsgf )
# alert b.history({operation: :write, id: :the_box, particle: :rotate})
# alert  Universe.current_machine
# alert  Universe.current_user
# alert grab(Universe.current_machine).inspect
#
# human({id: :jeezs, login: true})
#
# alert "current user: #{Universe.current_user}"
# wait 2 do
#   human({id: :toto, login: true})
#   alert "current user: #{Universe.current_user}"
#
# end
######### local storage
# JS.global[:localStorage].setItem('maCle', 'maValeur')
#
# valeur = JS.global[:localStorage].getItem('maCle')
# alert "avant : #{valeur}"
# JS.global[:localStorage].removeItem('maCle')
#
# valeur = JS.global[:localStorage].getItem('maCle')
# alert "apres : #{valeur}"

# ############### indexed db
#
# indexedDB = JS.global[:indexedDB] || JS.global[:mozIndexedDB] || JS.global[:webkitIndexedDB] || JS.global[:msIndexedDB] || JS.global[:shimIndexedDB]
#
# # Ouvrir (ou créer) la base de données
# open = indexedDB.open("MyDatabase", 1)
#
# # Créer le schéma
# open.addEventListener("upgradeneeded", proc do
#   db = open[:result]
#   store = db.createObjectStore("MyObjectStore", { keyPath: "id" })
#   index = store.createIndex("NameIndex", ["name.last", "name.first"])
# end)
#
# open.addEventListener("success", proc do
#   # Commencer une nouvelle transaction
#   db = open[:result]
#   tx = db.transaction("MyObjectStore", "readwrite")
#   store = tx.objectStore("MyObjectStore")
#   index = store.index("NameIndex")
#
#   # Ajouter des données
#   store.put({ id: 12345, name: { first: "John", last: "Doe" }, age: 42 })
#   store.put({ id: 67890, name: { first: "Bob", last: "Smith" }, age: 35 })
#
#   # Interroger les données
#   getJohn = store.get(12345)
#   getBob = index.get(["Smith", "Bob"])
#
#   getJohn.addEventListener("success", proc do
#     puts getJohn[:result][:name][:first] # => "John"
#   end)
#
#   getBob.addEventListener("success", proc do
#     puts getBob[:result][:name][:first] # => "Bob"
#   end)
#
#   # Fermer la base de données lorsque la transaction est terminée
#   tx.addEventListener("complete", proc do
#     db.close
#   end)
# end)
# ###################### uddate db
# # Ouvrir la base de données
# open_update = indexedDB.open("MyDatabase", 1)
#
# open_update.addEventListener("success", proc do
#   # Commencer une nouvelle transaction
#   db = open_update[:result]
#   tx = db.transaction("MyObjectStore", "readwrite")
#   store = tx.objectStore("MyObjectStore")
#   index = store.index("NameIndex")
#
#   # Obtenir l'objet Bob
#   getBob = index.get(["Smith", "Bob"])
#
#   getBob.addEventListener("success", proc do
#     bob = getBob[:result]
#
#     # Mettre à jour le prénom de Bob à Tim
#     bob[:name][:first] = "Tim"
#
#     # Remettre l'objet mis à jour dans le magasin d'objets
#     updateRequest = store.put(bob)
#
#     updateRequest.addEventListener("success", proc do
#       puts "Bob's first name has been updated to Tim!"
#     end)
#
#     updateRequest.addEventListener("error", proc do
#       puts "There was an error updating Bob's first name."
#     end)
#   end)
#
#   # Fermer la base de données lorsque la transaction est terminée
#   tx.addEventListener("complete", proc do
#     db.close
#   end)
# end)
# b=box({id: :poilu})
# b.left(7564)
