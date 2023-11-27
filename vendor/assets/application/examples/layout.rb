# frozen_string_literal: true
class HTML

  def toggle_display(container_class)
    container = JS.global[:document].querySelector("##{container_class}")
    # container = JS.global[:document].querySelector(".atome")

    if container[:classList].contains?("grid-display")
      container[:classList].remove("grid-display")
      container[:classList].remove("check")
      container[:classList].add("container")
    else
      container[:classList].add("grid-display")
      container[:classList].add("check")
      container[:classList].remove("container")
    end
  end
end

new({ particle: :layout }) do |p|
  # we create the conatiner
  container=  box
  # alert container.class
  # container_class=:my_val
  # container.html.add_class(container_class)
  container.html.toggle_display(box.id)
end

b = box

16.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45) })
end

b.layout({ atomes: b.duplicate.keys, display: :grid, rows: 4, column: 4 })
