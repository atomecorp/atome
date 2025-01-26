# # frozen_string_literal: true

b=box({ left: 12, id: :the_first_box })
color({ id: :the_lemon, red: 1, green: 1 })
color({ id: :the_see, red: 0.3, green: 0.6, blue: 1 })
wait 1 do
  b.apply([:the_lemon, :the_see])

  wait 1 do
    b.remove(:the_see)
  end
end



# To remove an apply color look at remove partcile

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
