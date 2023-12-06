# frozen_string_literal: true

class HTML

  def layout_style(option = {})
    element_style = {
      backgroundColor: 'rebeccapurple',
      width: '100%',
      height: '29px',
      borderRadius: '59px',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      flexDirection: 'column',
      marginBottom: '20px',
      padding: '0px'
    }

    container_style = {
      display: :grid,
      gridTemplateColumns: 'repeat(4, 1fr)',
      flexDirection: 'column',
      gap: '20px',
      padding: '0px',

    }
    element_style = element_style.merge(option[:element]) if option[:element]
    container_style = container_style.merge(option[:container]) if option[:container]
    @layout_style = { element: element_style, container: container_style }
  end

  def remove_layout(element, container)
    element[:classList].add('atome')
    element[:classList].remove('matrix_element')
  end

  def layout(params)
    id_found = params[:id]
    mode_found = params[:mode]
    width_found = params[:width]
    height_found = params[:height]
    layout_container = JS.global[:document].getElementById(id_found.to_s)
    layout_elements = JS.global[:document].querySelectorAll(".#{id_found}")
    layout_style({ element: { backgroundColor: :purple } })

    layout_container[:classList].remove('atome')
    layout_container[:classList].add('matrix')
    layout_elements.to_a.each do |element|
      # element[:style][property] = value.to_s
      element[:classList].remove('atome')
      element[:classList].add('matrix_element')

    end

    # test remove layout
    wait 2 do
      layout_elements.to_a.each do |element|
        remove_layout(element, layout_container)
      end
    end
  end

end

new({ particle: :layout }) do |params|

  mode_found = params[:mode] ||= :list
  layout_width = params[:width] ||= 333
  layout_height = params[:height] ||= 333

  # now we get the list of the atome to layout
  atomes_to_layout=[]
  if type == :group
    atomes_to_layout = collect
  end
  # if params[:list] is specified group collection is override
  atomes_to_layout = params[:list] if params[:list]

  if params[:id]
    container_name = params[:id]
    container = grab(:view).box({ id: container_name })
    container_class = container_name
  else
    container = grab(:view).box
    container_class = container.id
  end
  container.color({ alpha: 0.4 })
  container.overflow(:scroll)
  container.width = layout_width
  container.height = layout_height
  atomes_to_layout.each do |atome_id_to_layout|
    atome_to_layout = grab(atome_id_to_layout)
    atome_to_layout.attach(container_class)
    atome_to_layout.html.add_class(container_class)
  end

  # we return the list of atomes to layout
  params

end

new({ renderer: :html, method: :layout, type: :hash }) do |params, _user_proc|
  html.layout(params)
end

# system
Atome.new({ renderers: [:html], id: :selector, collect: [], type: :group, tag: { system: true } })

###############

# we create

b = box({ color: :red, id: :the_box, left: 3 })
16.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45), top: 0, category: :custom_category })
end

grab(:view).attached.each do |atome_found|
  grab(atome_found).selected(true)
end
grab(:the_box_copy_1).text(:hello)
#################@
selected_items = grab(Universe.current_user).selection # we create a group
# we collect all atomes in the view
atomes_found = []
selected_items.each do |atome_found|
  atomes_found << atome_found
end

random_found = atomes_found.sample(17)

random_found.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.left(rand(700))
    atome_found.width(rand(120))
    atome_found.height(rand(120))
    atome_found.smooth(rand(120))
    atome_found.color({ red: rand, green: rand, blue: rand })
  end
end
wait 1 do
  # alert selected_items.id
  selected_items.layout({ id: :my_layout, mode: :grid, width: 500, height: 500 })
  # selected_items.layout({ id: :my_layout, mode: :grid, width: 500, height: 500 })

  # wait 1 do
  #   selected_items.layout({ id: :my_layout, mode: :grid, width: 500, height: 500 })
  # end
end
