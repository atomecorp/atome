# frozen_string_literal: true

new ({ particle: :password, category: :security, type: :string })
new ({ sanitizer: :password }) do |params|

  params = { read: params, write: params } unless params.instance_of? Hash

  # encoding below
  params[:global] = Black_matter.encode(params[:global])

  params[:read]&.each do |k, v|
    params[:read][k] = Black_matter.encode(v)
  end
  params[:write]&.each do |k, v|
    params[:write][k] = Black_matter.encode(v)
  end

  params[:read] = Black_matter.password unless params[:read]
  params[:write] = Black_matter.password unless params[:write]

  if type == :human
    # we store the hashed password into the Universe for easier access
    Black_matter.set_password(params)
  end
  params
end

new({ read: :password }) do |params|
  # TODO : check if we have to reactive the lines below
  # params = Black_matter.password if params.nil?
  # params[:read][:atome] = Black_matter.password[:read][:atome] unless @authorisations[:write][:atome]
  # params[:write][:atome] = Black_matter.password[:write][:atome] unless @authorisations[:write][:atome]

  params
end

# def get_all_local_storage_items
  # Création d'un hash pour stocker les paires clé/valeur de localStorage
  storage_items = {}

  # Obtention du nombre d'éléments dans le localStorage
#   storage= JS.global[:localStorage]
# # storage=storage.to_s
# storage_array= storage.to_a
# # alert storage_array.length
# storage_items={}
# storage_array.each_with_index do |_i, index|
#   key = JS.global[:localStorage].key(index)
#   #
#   #     # Récupération de la valeur associée à cette clé
#       value = JS.global[:localStorage].getItem(key)
#   #
#   #     # Stockage de la paire clé/valeur dans le hash
#       storage_items[key] = value
# end
# puts storage_items

  # alert Native(storage_length).class
  # Itération sur tous les éléments de localStorage
#   (0...storage_length).each do |i|
#     # Récupération de la clé pour l'élément actuel
#     key = JS.global[:localStorage].key(i)
#
#     # Récupération de la valeur associée à cette clé
#     value = JS.global[:localStorage].getItem(key)
#
#     # Stockage de la paire clé/valeur dans le hash
#     storage_items[key] = value
#   end
#
#   # Retour du hash contenant toutes les paires clé/valeur de localStorage
#   storage_items
# end
#
# # Appel de la fonction pour récupérer et afficher le contenu de localStorage
# all_items = get_all_local_storage_items
# puts all_items