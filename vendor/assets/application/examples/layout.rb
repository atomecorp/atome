# frozen_string_literal: true

class Atome
  def remove_layout
    display(:default)
    # we get the current parent (the previous layout)
    parent_found = grab(attach)
    # we get the parent of the parent
    grand_parent = parent_found.attach
    # and attach the item to the grand parent
    # we remove the parent category and restore atome category
    remove({ category: attach })
    category(:atome)
    attach(grand_parent)
    #  we delete the parent (the layout) if it no more children attached
    if parent_found.attached.length == 0
      parent_found.delete(true)
    end
  end
end

# new({ particle: :backup })
new({ particle: :organise })
new({ particle: :backup })
new({ particle: :spacing })
new({ particle: :display }) do |params|
  unless params.instance_of? Hash
    params = { mode: params }
  end
  params
end

new({ method: :organise, renderer: :html }) do |params|
  html.style(:gridTemplateColumns, params)
end

new({ method: :spacing, renderer: :html }) do |params|
  html.style(:gap, "#{params}px")
end

new({ method: :display, renderer: :html }) do |params|
  # if params[:mode] == :default
  #   display_mode = :bloc
  # else
  #   display_mode = params[:mode]
  # end
  # puts "2 - particle :#{id} : #{params}"

  html.style(:display, params.to_s)
  # html.style(:display, 'flex')
end

new({ particle: :layout }) do |params|

  mode_found = params.delete(:mode) || :list
  elements_style = params.delete(:element) || {}
  # now we get the list of the atome to layout
  atomes_to_organise = []
  if type == :group
    atomes_to_organise = collect
  end
  # if params[:listing] is specified group collection is override
  atomes_to_organise = params[:listing] if params[:listing]
  if mode_found == :default
    # the user want to revert the layout to the default
    atomes_to_organise.each do |atome_id_to_organise|
      atome_found = grab(atome_id_to_organise)
      unless params[:id]
        params[:id] = atome_found.display[:layout]
      end
      # now restoring
      atome_found.backup.each do |particle, value|
        puts "#{particle} : #{value}"
        atome_found.send(:delete, particle)
        atome_found.send(particle, value)
      end
      # atome_found.display[:default].each do |particle, value|
      #   atome_found.send(:delete, particle)
      # end
      atome_found.remove_layout
    end
  else
    if params[:id]
      container_name = params[:id]
      container = grab(:view).box({ id: container_name })
      container_class = container_name
    else
      container = grab(:view).box
      id_found = container.id
      params[:id] = id_found
      container_class = id_found
    end
    container.remove({ category: :atome })
    container.category(:matrix)
    if mode_found == :list
      params[:organise] = '1fr'
    end
    params.each do |particle, value|
      container.send(particle, value)
    end
    # now we add user wanted particles
    atomes_to_organise.each do |atome_id_to_organise|
      atome_found = grab(atome_id_to_organise)

      # we remove previous display mode
      atome_found.remove_layout
      atome_found.display[:mode] = mode_found
      atome_found.display[:layout] = id_found
      atome_found.attach(container_class)
      atome_found.remove({ category: :atome })
      atome_found.category(container_class)
      # the hash below is used to restore element state

      # we only store the state if  atome_found.display[:default]== {} it means this is the original state
      elements_style.each do |particle, value|
        # we have to store all elements particle to restore it later
        atome_found.backup({})  unless atome_found.backup
        unless atome_found.backup[particle]
          particle_to_save = atome_found.send(particle) || 0
          atome_found.backup[particle] = particle_to_save
        end
        # we store if the isn't already in the backup

        # unless atome_found.display[:default][:particle]
        #   particle_to_save = atome_found.send(particle) || 0
        #   atome_found.display[:default][particle] = particle_to_save
        #   atome_found
        # end
        atome_found.send(particle, value)

        ###################### changes here #################
      end

      # elements_style.each do |particle, value| do
      #
      # end
      # we store the original state only if it is not empty
      #  unless original_state == {}
      #    atome_found.display[:default]=atome_found.display[:default].merge(original_state)
      #  end

    end

  end

  params
end

# system
Atome.new({ renderers: [:html], id: :selector, collect: [], type: :group, tag: { system: true } })

############### tests

b = box({ color: :red, id: :the_box, left: 3 })
5.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45), top: 0, category: :custom_category })
end

grab(:view).attached.each do |atome_found|
  grab(atome_found).selected(true)
end
grab(:the_box_copy_1).text(:hello)
#################
selected_items = grab(Universe.current_user).selection # we create a group
# we collect all atomes in the view
atomes_found = []
selected_items.each do |atome_found|
  atomes_found << atome_found
end
# random test
random_found = atomes_found.sample(17)

random_found.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.left(rand(700))
    atome_found.width(rand(200))
    atome_found.height(rand(200))
    # atome_found.rotate(rand(90))
    atome_found.smooth(rand(120))
    atome_found.color({ red: rand, green: rand, blue: rand })
  end
end

# selected_items.each do |atome_id_found|
#   atome_found=grab(atome_id_found)
#   rand_width=rand(300)
#   # atome_found.display[:default][:width]=rand_width
#
#     atome_found.backup({})  unless atome_found.backup
#
#   atome_found.backup[:width]=rand_width
#   atome_found.width(rand_width)
#   puts  "#{atome_found.id} #{atome_found.width} : #{atome_found.backup }"
# end
#
# puts '------'
#
# selected_items.each do |atome_id_found|
#   atome_found=grab(atome_id_found)
#   puts  "#{atome_found.id} #{atome_found.width} :  #{atome_found.backup}"
# end




# Simple check
# wait 1 do
#   selected_items.layout({ mode: :grid, width: 900, height: 500, color: :green, element: { rotate: 22, height: 66, width: 66 } })
#   wait 1 do
#     selected_items.layout({ mode: :default, width: 500,  height: 22 , top: 120})
#   end
# end
#
#""
# # b.touch(true) do
# #   selected_items.layout({ mode: :grid, width: 900, height: 500, color: :green, element: { width: 11 } })
# # end
#
# selected_items.layout({ mode: :grid, width: 900, height: 500, color: :green, element: { height: 21 } })

# selected_items.layout({ id: :my_layout, mode: :list, width: 500, height: 800, overflow: :scroll, display:  :flex  })

# full check
wait 1 do
  selected_items.layout({ mode: :grid, width: 900, height: 500, color: :green, element: { rotate: 22, height: 100, width: 150 } })
#   # puts "1 #{b.display}"
  wait 1 do
    selected_items.layout({ mode: :grid, width: 80, height: 500 , overflow: :scroll})
    # puts "2 #{b.display}"
    wait 1 do
      selected_items.layout({ mode: :default, width: 500,  height: 22 })
      # puts "3 #{b.display}"
      wait 1 do
        selected_items.layout({ id: :my_layout, mode: :list, width: 800, height: 800, overflow: :scroll, element: { height: 22, width: 800 } })
#         # puts "4 #{b.display}"
        wait 1 do
          selected_items.layout({ mode: :default})
#           # puts "5 #{b.display}"
        end
      end
    end
  end
end

#

b.color(:black)
b.width(120)
b.height(120)
b.left(300)
b.top(300)
# cccc=circle({display: {mode:  :flex }})