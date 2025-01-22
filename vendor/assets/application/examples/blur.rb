# # frozen_string_literal: true
#
# b=circle({left: 333})
# b.blur(6)
#
# image(:red_planet)
# b2=box({color: {alpha: 0.1, red: 1, green: 0, blue: 0.2}, left: 99, top: 99, width: 99, height: 99})
# b2.drag(true)
# b2.border({ thickness: 0.3, color: :gray, pattern: :solid })
# b2.smooth(12)
# b2.shadow({
#             invert: true,
#             id: :s4,
#             left: 2, top: 2, blur: 9,
#             # option: :natural,
#             red: 0, green: 0, blue: 0, alpha: 0.3
#           })
#
# b2.shadow({
#             # invert: true,
#             id: :s5,
#             left: 2, top: 2, blur: 9,
#             # option: :natural,
#             red: 0, green: 0, blue: 0, alpha: 0.6
#           })
# b2.blur({affect: :back, value: 15})
# t=b2.text({data:  ':hello', position: :absolute })
# t.edit=true
# def api_infos
#   {
#   "example": "Purpose of the example",
#   "methods_found": [
#     "1",
#     "2",
#     "3",
#     "6",
#     "blur",
#     "border",
#     "drag",
#     "shadow",
#     "smooth"
#   ],
#   "1": {
#     "aim": "The `1` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `1`."
#   },
#   "2": {
#     "aim": "The `2` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `2`."
#   },
#   "3": {
#     "aim": "The `3` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `3`."
#   },
#   "6": {
#     "aim": "The `6` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `6`."
#   },
#   "blur": {
#     "aim": "The `blur` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `blur`."
#   },
#   "border": {
#     "aim": "The `border` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `border`."
#   },
#   "drag": {
#     "aim": "The `drag` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `drag`."
#   },
#   "shadow": {
#     "aim": "The `shadow` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `shadow`."
#   },
#   "smooth": {
#     "aim": "Applies smooth transitions or rounded edges to an object.",
#     "usage": "Use `smooth(20)` to apply a smooth transition or corner rounding of 20 pixels."
#   }
# }
# end
