# #  frozen_string_literal: true
b = box

first_wait=wait 2 do
  b.color(:red)
end
wait 1 do
  puts 'now'
  stop({ wait: first_wait })
  # or
  # wait(:kill, first_wait)
end


wait 3 do
  b.color(:green)
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  }
}
end
