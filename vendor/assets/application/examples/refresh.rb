# frozen_string_literal: true

b = box({ top: 166, data: :hello })
c=color({ id: :col1, red: 1, blue: 1})

b.instance_variable_set("@top", 30)
b.instance_variable_set("@apply", [c.id])
b.instance_variable_set("@path", './medias/images/red_planet.png' )

b.instance_variable_set("@smooth", 30)
wait 1 do
  b.refresh
  b.instance_variable_set("@left", 300)
  wait 1 do
    b.refresh
    b.instance_variable_set("@type", :text)
    wait 1 do
      b.refresh
      b.instance_variable_set("@type", :image)
      wait 1 do
        b.refresh
      end
    end
  end
end
i=image(:green_planet)
# alert i.path
i.instance_variable_set("@path", './medias/images/red_planet.png')
wait 2 do
  i.refresh
  # i.path'./medias/images/red_planet.png'
end


#
# b.instance_variable_set("@left", 300)
# b.instance_variable_set("@top", 400)
# # b.instance_variable_set("@width", 150)
#
# # b.instance_variable_set("@smooth", 9)
# # new({particle: :tototo})
#
# wait 1 do
#   b.refresh
#   # b.instance_variable_set("@type", :text)
#   b.instance_variable_set("@smooth", 9)
#   b.instance_variable_set("@apply", [c.id])
#   wait 1 do
#     b.refresh
#     # b.instance_variable_set("@type", :image)
#     # wait 1 do
#     #   alert b.type
#     #   # b.refresh
#     # end
#   end
# end
#
# t=text(:test)
# t.touch(true) do
#   b.smooth(9)
#   b.refresh
# end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "id",
    "instance_variable_set",
    "path",
    "png",
    "refresh",
    "smooth",
    "touch",
    "type"
  ],
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "instance_variable_set": {
    "aim": "The `instance_variable_set` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_variable_set`."
  },
  "path": {
    "aim": "The `path` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `path`."
  },
  "png": {
    "aim": "The `png` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `png`."
  },
  "refresh": {
    "aim": "The `refresh` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `refresh`."
  },
  "smooth": {
    "aim": "Applies smooth transitions or rounded edges to an object.",
    "usage": "Use `smooth(20)` to apply a smooth transition or corner rounding of 20 pixels."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "type": {
    "aim": "The `type` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `type`."
  }
}
end
