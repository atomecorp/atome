# frozen_string_literal: true

# t = text({ int8: { english: :hello, french: :salut, deutch: :halo } })

# wait 1 do
#   t.language(:french)
#   wait 1 do
#     t.language(:english)
#     # data is updated to the latest choice
#     puts t.data
#     wait 1 do
#       t.data(:hi)
#     end
#   end
# end

Universe.translation[:hello] = { english: :hello, french: :salut, deutch: :halo }

b = box({ left: 155, drag: true, id: :boxy })
t=b.text({ data: :hello, id: :t1, position: :absolute, color: :black })
t2 = b.text({ data: :hello, id: :t2, left: 9, top: 33, position: :absolute })

# wait 1 do
#   b.instance_variable_set('@top', 255)
#   # b.refresh
#   wait 1 do
#     # refresh
#   end
# end

# b.refresh


Universe.language = :french
wait 1 do
  puts "1"

  # t.refresh
  t2.refresh
  Universe.language = :deutch
  ########

  # wait 1 do
  #
  #   Universe.language = :deutch
  #   # grab(:t2).refresh
  #
  #   # refresh
  #
  #
  #   atome_ids_found=grab(:view).fasten.dup
  #   atome_ids_found.each do |atome_id_found|
  #     atome_id_found=atome_id_found.to_sym
  #     # alert atome_id_found
  #     grab(atome_id_found).refresh
  #   end
  # end

  #######



end

    # t.language(:english)
    # alert t.language
    # wait 1 do
    #   t.refresh
    # end
    # wait 1 do
    #
    #   wait 1 do
    #     t.data(:hi)
    #     wait 1 do
    #       t.data(:hello)
    #       wait 1 do
    #         Universe.language=:english
    #         t.refresh
    #         # t.data(:hello)
    #       end
    #     end
    #   end
    # end
    # puts t.data

    # Universe.language=:english
    # Universe.translation[:hello]={ english: :hello, french: :salut, deutch: :halo }
    #
    # c=circle({drag: true})
    # a=c.text({id: :tutu, data: :hello})
    #
    # Universe.language=:french
    # a.color(:red)
    #
    #
    # wait 1 do
    #   id_found=a.id
    #   a.id(:item_to_trash)
    #    a.duplicate({ id: id_found})
    # end


######################@
# def fetch_all_children(view, &block)
#   all_children = []
#
#   # Méthode interne pour la récursion
#   fetch_children_recursively = lambda do |parent, depth|
#     children_ids = parent.fasten  # Assumons que 'fasten' renvoie les IDs des enfants
#
#     # Si des enfants sont trouvés, traiter récursivement
#     if children_ids.any?
#       children_ids.each do |child_id|
#         child = grab(child_id)  # Récupérer l'objet enfant par son ID
#         fetch_children_recursively.call(child, depth + 1)
#       end
#     end
#
#     # Ajouter les enfants au tableau principal avec leur profondeur
#     unless parent == view
#       all_children << { depth: depth, child: parent }
#     end
#   end
#
#   # Démarrer la récursion avec la vue principale et la profondeur initiale 0
#   fetch_children_recursively.call(view, 0)
#
#   # Trier les enfants par profondeur décroissante
#   sorted_children = all_children.sort_by { |entry| -entry[:depth] }
#
#   # Appeler le bloc sur chaque enfant trié
#   sorted_children.each do |entry|
#     block.call(entry[:child])
#   end
# end

# Last child after
def fetch_all_children(view, &block)
  all_children = []

  # Méthode interne pour la récursion
  fetch_children_recursively = lambda do |parent, depth|
    children_ids = parent.fasten  # Assumons que 'fasten' renvoie les IDs des enfants

    # Si des enfants sont trouvés, traiter récursivement
    if children_ids.any?
      children_ids.each do |child_id|
        child = grab(child_id)  # Récupérer l'objet enfant par son ID
        fetch_children_recursively.call(child, depth + 1)
      end
    end

    # Ajouter les enfants au tableau principal avec leur profondeur
    unless parent == view
      all_children << { depth: depth, child: parent }
    end
  end

  # Démarrer la récursion avec la vue principale et la profondeur initiale 0
  fetch_children_recursively.call(view, 0)

  # Trier les enfants par profondeur croissante
  sorted_children = all_children.sort_by { |entry| entry[:depth] }

  # Appeler le bloc sur chaque enfant trié
  sorted_children.each do |entry|
    block.call(entry[:child])
  end
end
wait 3 do
  parent = grab(:view)
  fetch_all_children(parent) do |child|
      child.refresh
  end

end


