# frozen_string_literal: true


class HTML

  # def toggle_display(container_class)
  #   container = JS.global[:document].querySelector("##{container_class}")
  #   container = JS.global[:document].querySelector(".atome")
  #   if container[:classList].contains?("grid-display")
  #     container[:classList].remove("grid-display")
  #     container[:classList].remove("check")
  #     container[:classList].add("container")
  #   else
  #     container[:classList].add("grid-display")
  #     container[:classList].add("check")
  #     container[:classList].remove("container")
  #   end
  # end
end

new({ particle: :layout }) do |params|
  mode_found = params[:mode]
  layout_width= params[:width] ||= 333
  layout_height= params[:height] ||= 333

  # now we get the list of the atome to layout
  if type == :group
    atomes_to_layout = collect
  end
  # if params[:list] iis specified group collection is override
  atomes_to_layout = params[:list] if params[:list]

  if params[:id]
    container_name = params[:id]
    container=grab(:view).box({id: container_name})
    container_class = container_name
  else
    container = grab(:view).box
    container_class = container.id
  end
  container.color({ alpha: 0.4 })
  container.overflow(:scroll)
  container.width=layout_width
  container.height=layout_height
  atomes_to_layout.each do |atome_id_to_layout|
    atome_to_layout = grab(atome_id_to_layout)
    atome_to_layout.attach(container_class)
    atome_to_layout.html.add_class(container_class)
  end

  # we return the list of atomes to layout
  atomes_to_layout

end

# system
Atome.new({ renderers: [:html], id: :selector, collect: [], type: :group, tag: { system: true } })

###############
# we create
container = box({id: :toto, width: 500, height: 500, overflow: :scroll })

b = container.box({ color: :red, id: :the_box, left: 3 })
16.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45), top: 0, category: :matrix })
end
container.attached.each do |atome_found|
  grab(atome_found).selected(true)
end

# new({ read: :selection }) do |params_get|
#   selector = grab(:selector)
#   selector.collect = params_get
#   selector
# end

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
# selected_items.rotate(9)

selected_items.layout({ id: :my_layout, mode: :grid, width: 500, height: 500 })
# alert selected_items.collect
# selected_items.color(:green)
# container.layout({ atomes: b.duplicate.keys, display: :grid, rows: 4, column: 4})
