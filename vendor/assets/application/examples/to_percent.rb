# frozen_string_literal: true

b=box
t=text({width: 66, left: 99,top: 66, data: "touch the bow and resize the window"})

b.touch(true) do
  b.width(t.to_percent(:width))
  b.left(t.to_percent(:left))
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "left",
    "to_percent",
    "touch",
    "width"
  ],
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "to_percent": {
    "aim": "The `to_percent` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_percent`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
