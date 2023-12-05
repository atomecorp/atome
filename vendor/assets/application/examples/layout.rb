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

new({ particle: :layout }) do |p|
  # we create the container
  container=  box(color: :red)
  container_class=:my_layout
  container.html.add_class(container_class)
end

# system
Atome.new({ renderers: [:html], id: :selector,collect: [], type: :group, tag: { system: true } })

###############
# we craete
# container= box({width: 500, height: 500, overflow: :scroll})

# b=container.box({ color: :red, id: :the_box, left: 3 })
b=box
# alert 'use category top assign class then port hybrid.html to atom'
16.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45) , top: 0, category: :matrix })
end

container.attached.each do |atome_found|
  grab(atome_found).selected(true)
end


new({read: :selection}) do |params_get|
  selector= grab(:selector)
  selector.collect = params_get
  selector
end
#################@
selected_items= grab(Universe.current_user).selection

# random_found =selected_items.sample(7)

# selected_items.rotate(9)

selected_items.layout({id: :my_layout, mode: :grid})
selected_items.color(:green)
# container.layout({ atomes: b.duplicate.keys, display: :grid, rows: 4, column: 4})
