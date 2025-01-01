#  frozen_string_literal: true

b = box({ left: 333, color: :blue, smooth: 6, id: :the_box2 })

t = text({ id: :the_text, data: 'type of touch : ?' })

t.touch(:down) do |event|
  puts :down
  puts event[:pageX]
  puts event[:pageY]
  b.touch({ remove: :down })
  t.data('down removed !! ')
end

touch_code = lambda do
  b.color(:red)
  puts 'box tapped'
end
b.touch(tap: true, code: touch_code)

b.touch(:long) do
  { color: :cyan }
  t.data('type of touch is : long ')
end

b.touch(:up) do
  t.data('type of touch is : up ')
  b.color(:orange)
end

b.touch(:down) do
  t.data('type of touch is : down ')
  b.color(:white)
end

b.touch(:double) do
  t.color(:red)
  t.data('type of touch is : double ')
  b.color(:yellowgreen)
end




def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "data",
    "touch"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
