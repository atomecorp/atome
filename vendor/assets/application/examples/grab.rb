#  frozen_string_literal: true

# the grab method is used to retrieve atome using their ID
a = box({ id: :my_box })

# to alter or add a particle you can use the variable, here we set the left value
a.left(33)

# to alter or add a particle you can use the variable
# it's also possible to alter or add a particle without a variable using grab and the ID of the atome , here we set the top value

wait 1 do
  grab(:my_box).top(5)
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "left"
  ],
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  }
}
end
