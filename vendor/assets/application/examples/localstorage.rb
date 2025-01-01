# frozen_string_literal: true
t=text("touch the box to erase localstorage, long touch on the box to stop historicize")
b=box({top: 66})
c=circle({top: 99})
c.touch(true) do
  c.left(c.left+99)
  # c.left=c.left+33
  # box
end
b.touch(true) do
  JS.eval('localStorage.clear()')
end

b.touch(:long) do
  b.color(:red)
  Universe.allow_localstorage = false

end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "allow_localstorage",
    "clear",
    "color",
    "eval",
    "left",
    "touch"
  ],
  "allow_localstorage": {
    "aim": "The `allow_localstorage` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `allow_localstorage`."
  },
  "clear": {
    "aim": "The `clear` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `clear`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
