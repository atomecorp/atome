# frozen_string_literal: true

b = box({ width: 200, height: 200, color: :white })

a = b.box({ color: :green, left: 33, id: :box, shadow: {
  id: :menu_active_shade,
  left: 9,
  top: -3,
  blur: 10,
  invert: false,
  red: 0,
  green: 0,
  blue: 0,
  alpha: 1 } })
wait 2 do
  a.exchange({ color: :red, top: 33})
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "exchange"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "exchange": {
    "aim": "The `exchange` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `exchange`."
  }
}
end
