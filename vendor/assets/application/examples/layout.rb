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

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "current_user",
    "duplicate",
    "each",
    "layout",
    "left",
    "times",
    "width"
  ],
  "current_user": {
    "aim": "The `current_user` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `current_user`."
  },
  "duplicate": {
    "aim": "The `duplicate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `duplicate`."
  },
  "each": {
    "aim": "The `each` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `each`."
  },
  "layout": {
    "aim": "The `layout` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `layout`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "times": {
    "aim": "The `times` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `times`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
