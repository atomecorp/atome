# frozen_string_literal: true

#remove an apply particle
b = box({ top: 166, id: :the_box, left: 333 })
b.color({ id: :green, green: 1 })
b.color({ id: :new_col, red: 1 })
b.color({ id: :blue, blue: 1 })
b.touch(true) do
  b.remove(:new_col)
  # wait 1 do
    grab('box_color').red(1)
  # end
end
# b.color({id: :other_col,  green: 1})
# # b.paint({gradient: [:other_col, :new_col]})
# color({id: :last_col,  green: 0.3, blue: 0.5})
# color({id: :last_col2,  red: 1, blue: 0.5})
#
# b.shadow({
#            id: :s1,
#            # affect: [:the_circle],
#            left: 9, top: 3, blur: 9,
#            invert: false,
#            red: 0, green: 0, blue: 0, alpha: 1
#          })
#
#
# wait 1 do
#   b.remove(:other_col)
#   wait 1 do
#     b.remove(:new_col)
#     wait 1 do
#       b.remove(:box_color)
#
#       wait 1 do
#         b.apply(:last_col)
#         wait 1 do
#           b.apply(:last_col2)
#           b.remove(:s1)
#         end
#       end
#     end
#   end
# end
# b.touch(true) do
#   b.shadow({
#              id: :s1,
#              # affect: [:the_circle],
#              left: 9, top: 3, blur: 9,
#              invert: false,
#              red: 0, green: 0, blue: 0, alpha: 1
#            })
#
#   puts "before => #{b.apply}"
#   b.remove({all: :color})
#   puts "after => #{b.apply}"
#   wait 1 do
#     b.paint({id: :the_gradient_1,gradient: [:box_color, :circle_color]})
#     b.paint({id: :the_gradient,gradient: [:other_col, :new_col]})
#     wait 1 do
#       b.remove(:the_gradient)
#       wait 1 do
#         b.remove(all: :shadow)
#         b.color(:cyan)
#       end
#     end
#   end
# end
#

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "3",
    "5",
    "apply",
    "color",
    "paint",
    "remove",
    "shadow",
    "touch"
  ],
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "apply": {
    "aim": "The `apply` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `apply`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "paint": {
    "aim": "The `paint` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `paint`."
  },
  "remove": {
    "aim": "The `remove` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `remove`."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
