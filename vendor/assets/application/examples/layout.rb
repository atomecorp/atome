# frozen_string_literal: true

b = box({ color: :red, id: :the_box, left: 3 })
5.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45), top: 0, category: :custom_category })
end

grab(:view).fasten.each do |atome_found|
  grab(atome_found).selected(true)
end
grab(:the_box_copy_1).text(:hello)

selected_items = grab(Universe.current_user).selection # we create a group
# we collect all atomes in the view
atomes_found = []
selected_items.each do |atome_found|
  atomes_found << atome_found
end


selected_items.layout({ mode: :default, width: 500, height: 22 })

wait 1 do
  selected_items.layout({ mode: :grid, width: 900, height: 500, color: :green, element: { rotate: 22, height: 100, width: 150 } })
  wait 1 do
    selected_items.layout({ mode: :grid, width: 1200, height: 500, overflow: :scroll })
    wait 1 do
      selected_items.layout({ mode: :default, width: 500, height: 22 })
      wait 1 do
        selected_items.layout({ id: :my_layout, mode: :list, width: 800, height: 800, overflow: :scroll, element: { height: 22, width: 800 } })
        wait 1 do
          selected_items.layout({ mode: :default })
        end
      end
    end
  end
end
