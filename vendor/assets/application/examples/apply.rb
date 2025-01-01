# # frozen_string_literal: true

b=box({ left: 12, id: :the_first_box })
color({ id: :the_lemon, red: 1, green: 1 })
wait 1 do
  b.apply(:the_lemon)
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "apply"
  ],
  "apply": {
    "aim": "The `apply` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `apply`."
  }
}
end
