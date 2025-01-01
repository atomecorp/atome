# frozen_string_literal: true

box({ left: 12, id: :the_first_box })
c=color({ id: :the_col, blue: 0.21, green: 1 })

wait 1 do
  c.affect(:the_first_box)
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "21",
    "affect"
  ],
  "21": {
    "aim": "The `21` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `21`."
  },
  "affect": {
    "aim": "The `affect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `affect`."
  }
}
end
