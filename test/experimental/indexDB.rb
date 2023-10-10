#  frozen_string_literal: true

indexedDB = JS.global[:indexedDB] || JS.global[:mozIndexedDB] || JS.global[:webkitIndexedDB] || JS.global[:msIndexedDB] || JS.global[:shimIndexedDB]

# Ouvrir (ou créer) la base de données
open = indexedDB.open("MyDatabase", 1)

# Créer le schéma
open.addEventListener("upgradeneeded", proc do
  db = open[:result]
  store = db.createObjectStore("MyObjectStore", { keyPath: "id" })
  store.createIndex("NameIndex", ["name.last", "name.first"])
end)

open.addEventListener("success", proc do
  # Commencer une nouvelle transaction
  db = open[:result]
  tx = db.transaction("MyObjectStore", "readwrite")
  store = tx.objectStore("MyObjectStore")
  index = store.index("NameIndex")

  # Ajouter des données
  store.put({ id: 12345, name: { first: "John", last: "Doe" }, age: 42 })
  store.put({ id: 67890, name: { first: "Bob", last: "Smith" }, age: 35 })

  # Interroger les données
  getJohn = store.get(12345)
  getBob = index.get(["Smith", "Bob"])

  getJohn.addEventListener("success", proc do
    puts getJohn[:result][:name][:first] # => "John"
  end)

  getBob.addEventListener("success", proc do
    puts getBob[:result][:name][:first] # => "Bob"
  end)

  # Fermer la base de données lorsque la transaction est terminée
  tx.addEventListener("complete", proc do
    db.close
  end)
end)
# ###################### update db
# Ouvrir la base de données
open_update = indexedDB.open("MyDatabase", 1)

open_update.addEventListener("success", proc do
  # Commencer une nouvelle transaction
  db = open_update[:result]
  tx = db.transaction("MyObjectStore", "readwrite")
  store = tx.objectStore("MyObjectStore")
  index = store.index("NameIndex")

  # Obtenir l'objet Bob
  getBob = index.get(["Smith", "Bob"])

  getBob.addEventListener("success", proc do
    bob = getBob[:result]

    # Mettre à jour le prénom de Bob à Tim
    bob[:name][:first] = "Tim"

    # Remettre l'objet mis à jour dans le magasin d'objets
    updateRequest = store.put(bob)

    updateRequest.addEventListener("success", proc do
      puts "Bob's first name has been updated to Tim!"
    end)

    updateRequest.addEventListener("error", proc do
      puts "There was an error updating Bob's first name."
    end)
  end)

  # Fermer la base de données lorsque la transaction est terminée
  tx.addEventListener("complete", proc do
    db.close
  end)
end)