# frozen_string_literal: true
def act_on(obj)
  obj.color(:red)
  obj.left(56)
end

def act_off(obj)
  obj.color(:blue)
  obj.left(33)
end


b = box({ left: 12, id: :the_first_box, top: 30 })

b.touch(true) do
  b.alternate({ width: 33, color: :red, height: 33 , smooth: 0 }, { width: 66, color: :orange, blur: 8}, { height: 66, color: :green, smooth: 9, blur: 0})
end

c = circle({ left: 99 , top: 30})

c.touch(true) do
  alt = b.alternate(true, false)
  if alt
    c.color(:yellowgreen)
  else
    c.color(:orange)
  end
end


c2 = circle({ left: 333 , top: 30})


c2.touch(true) do
  b.alternate({  executor: {act_on: b}  }, { executor: {act_off: b}})
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "alternate",
    "color",
    "left",
    "touch"
  ],
  "alternate": {
    "aim": "The `alternate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `alternate`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
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
