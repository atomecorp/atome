#  frozen_string_literal: true

b = box({ drag: true, id: :the_b })
c = b.circle({ left: 99, id: :the_c })
d = b.text({ data: :hello, left: 44, top: 44, id: :the_t })
c.touch(:down) do
  c.detach(b.id)
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "circle",
    "detach",
    "id",
    "text",
    "touch"
  ],
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "detach": {
    "aim": "The `detach` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `detach`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
