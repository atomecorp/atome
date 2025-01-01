# frozen_string_literal: true

b = box({ top: 166, data: :hello,path: './medias/images/red_planet.png'  })
b.color({ id: :col1, red: 1, blue: 1})

# b.instance_variable_set("@top", 30)
# b.instance_variable_set("@apply", [c.id])
# b.instance_variable_set("@path",  )

# b.instance_variable_set("@smooth", 30)
wait 1 do
  b.type=:text
  b.refresh
  wait 1 do
    b.type=:image
    b.refresh
  end
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "id",
    "instance_variable_set",
    "png",
    "refresh",
    "type"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "instance_variable_set": {
    "aim": "The `instance_variable_set` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_variable_set`."
  },
  "png": {
    "aim": "The `png` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `png`."
  },
  "refresh": {
    "aim": "The `refresh` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `refresh`."
  },
  "type": {
    "aim": "The `type` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `type`."
  }
}
end
