# frozen_string_literal: true

b = box({ width: 333, left: 333 })
b.smooth(9)

wait 2 do
  b.smooth([33, 2, 90])
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "smooth"
  ],
  "smooth": {
    "aim": "Applies smooth transitions or rounded edges to an object.",
    "usage": "Use `smooth(20)` to apply a smooth transition or corner rounding of 20 pixels."
  }
}
end
