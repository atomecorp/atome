#  frozen_string_literal: true

new({particle: :select})
t = text :hello
t.left(99)

t.edit(true)

b=box
b.touch(true) do
  puts t.data
  t.component({ selected: true })
end

# # frozen_string_literal: true
#
# c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })
# col = c.color({ id: :col1, red: 1, blue: 1 })
# wait 2 do
#   col.red(0.6)
#   wait 2 do
#     col.red(0) # Appel en écriture
#   end
# end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "6",
    "color",
    "component",
    "data",
    "edit",
    "left",
    "red",
    "touch"
  ],
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "component": {
    "aim": "The `component` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `component`."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "edit": {
    "aim": "The `edit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `edit`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "red": {
    "aim": "The `red` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `red`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
