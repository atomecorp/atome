#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
b.over(true) do
  b.color(:black)
  # puts "I'm inside"
end
b.over(:enter) do
  puts "in"
  puts "enter"
  b.width= b.width+30
  b.color(:yellow)
end
b.over(:leave) do
  b.height= b.height+10
  puts "out"
  puts "leave"
  # alert :out
  b.color(:orange)
end

#
t=b.text('touch me to stop over leave')
b.touch(true) do
  b.over({ remove: :enter })
  t.data('finished')
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "data",
    "height",
    "over",
    "text",
    "touch",
    "width"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "over": {
    "aim": "The `over` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `over`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
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
