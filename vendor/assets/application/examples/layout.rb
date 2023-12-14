# frozen_string_literal: true

# class HTML
#
#   def layout_style(option = {})
#     element_style = {
#       backgroundColor: 'rebeccapurple',
#       width: '100%',remove_layout
#       height: '29px',
#       borderRadius: '59px',
#       display: 'flex',
#       justifyContent: 'center',
#       alignItems: 'center',
#       flexDirection: 'column',
#       marginBottom: '20px',
#       padding: '0px',
#       # transform: 'rotate(22deg)',
#
#     }
#
#     container_style = {
#       display: :grid,
#       gridTemplateColumns: 'repeat(4, 1fr)',
#       overflow: :scroll,
#       flexDirection: 'column',
#       gap: '20px',
#       padding: '0px',
#
#     }
#     element_style = element_style.merge(option[:element]) if option[:element]
#     container_style = container_style.merge(option[:container]) if option[:container]
#     @layout_style = { element: element_style, container: container_style }
#   end
#
#   def remove_webview_layout(element, container)
#     element[:classList].add('atome')
#     element[:classList].remove('matrix_element')
#   end
#
#   def layout(params)
#
#     id_found = params[:id]
#     mode_found = params[:mode]
#     width_found = params[:width]
#     height_found = params[:height]
#     layout_container = JS.global[:document].getElementById(id_found.to_s)
#     layout_elements = JS.global[:document].querySelectorAll(".#{id_found}")
#     if mode_found == :default
#       # we revert all elements to default state / layout
#       layout_elements.to_a.each do |element|
#         element[:classList].remove('matrix_element')
#         element[:classList].add('atome')
#       end
#     else
#       # we apply new layout to  elements
#       layout_style({ element: { backgroundColor: :purple } })
#       layout_container[:classList].remove('atome')
#       layout_container[:classList].add('matrix')
#       layout_elements.to_a.each do |element|
#         # we check if current state is default if yes we store the layout to be able to restore it
#         element[:style][:borderRadius] = '59px'
#         element[:classList].remove('atome')
#         # element[:classList].add('matrix_element')
#       end
#     end
#
#   end
# end

# class HTML
#
#   def
#
# end

class Atome
  def remove_layout
    display[:mode] = :default
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

new({ particle: :layout }) do |params|
  mode_found = params.delete(:mode) || :list
  elements_style = params.delete(:element) || {}
  # layout_width = params[:width] ||= 333
  # layout_height = params[:height] ||= 333
  # now we get the list of the atome to layout
  atomes_to_layout = []
  if type == :group
    atomes_to_layout = collect
  end
  # if params[:list] is specified group collection is override
  atomes_to_layout = params[:list] if params[:list]

  if mode_found == :default
    # the user want to revert the layout to the default
    atomes_to_layout.each do |atome_id_to_layout|
      atome_to_layout = grab(atome_id_to_layout)
      unless params[:id]
        params[:id] = atome_to_layout.display[:layout]
      end
      # now we get the default particles and restore it
      atome_to_layout.display[:default].each do |particle, value|
        atome_to_layout.send(:delete, particle)
        atome_to_layout.send(particle, value)
      end

      atome_to_layout.remove_layout
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
    puts "mode_found >> #{mode_found}"
    params.each do |particle, value|
      container.send(particle, value)
    end
    # now we add user wanted particles
    puts "params #{params}"

    atomes_to_layout.each do |atome_id_to_layout|
      atome_to_layout = grab(atome_id_to_layout)
      # we remove previous display mode
      atome_to_layout.remove_layout
      atome_to_layout.display[:mode] = mode_found
      atome_to_layout.display[:layout] = id_found
      atome_to_layout.attach(container_class)
      atome_to_layout.remove({ category: :atome })
      atome_to_layout.category(container_class)
      # the hash below is used to restore element state
      original_state = {}
      elements_style.each do |particle, value|
        # we have to store all elements particle to restore it later
        original_state[particle] = atome_to_layout.send(particle)
        atome_to_layout.send(particle, value)
      end
      atome_to_layout.display[:default] = original_state
      # atome_to_layout.html.add_class(container_class)
    end
  end
  params
end

new({ particle: :display })

# system
Atome.new({ renderers: [:html], id: :selector, collect: [], type: :group, tag: { system: true } })

############### tests

b = box({ color: :red, id: :the_box, left: 3 })
16.times do |index|
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

# Simple verif

selected_items.layout({ id: :my_layout, mode: :list, width: 500, height: 800, overflow: :scroll })

# # full verif
# wait 1 do
#   selected_items.layout({ mode: :grid, width: 900, height: 500, color: :green,element: {height: 22, rotate: 22} })
#   # alert grab('the_box_copy_4').display
#   wait 1 do
#     # selected_items.layout({ mode: :grid, width: 800, height: 500 })
#     wait 1 do
#       selected_items.layout({ mode: :default, width: 500, height: 500 })
#       # alert grab('the_box_copy_4').display
#       wait 1 do
#         selected_items.layout({ id: :my_layout, mode: :list, width: 151, height: 800, overflow: :scroll })
#         wait 1 do
#           selected_items.layout({ mode: :default, width: 500, height: 500 })
#         end
#       end
#     end
#   end
# end
#
#
# # random test
# random_found = atomes_found.sample(17)
#
# random_found.each do |atome_id|
#   atome_found = grab(atome_id)
#   if atome_found.type == :shape
#     atome_found.left(rand(700))
#     atome_found.width(rand(120))
#     atome_found.height(rand(120))
#     atome_found.smooth(rand(120))
#     atome_found.color({ red: rand, green: rand, blue: rand })
#   end
# end