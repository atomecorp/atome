# require './examples/attach'
# TODO: find and remove : dbQKhb876HZggd87Hhsgf
# https://github.com/travist/jsencrypt

###### ruby integration for encode
# my_pass=Black_matter.encode('hello')
# alert my_pass
# checker=Black_matter.check_password('hello,', my_pass)
# alert checker
######## security particles and security

b = box({ id: :the_box, left: 66,
          security: {
            smooth: {
              write: { password: :other_pass },
              read: { password: :read_pass }
            }
          }
        })

class Atome
  def authorise(password, destroy = true)
    @temps_authorisation = [password, destroy]
  end
end

b.authorise(:star_wars, false)
b.smooth(22)
b.authorise(:star_war, true)
b.smooth(66)
puts '----'
puts "b.security : #{b.security}"
puts '----'
puts "user hashed pass is : #{grab(Universe.current_user).password}"
# alert b.instance_variable_get("@security")

puts "b.smooth is : #{b.smooth}"
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
# Black_matter.synchronised(582,:star_wars)
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
