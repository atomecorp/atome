#  frozen_string_literal: true

t = text :hello
t.left(99)

t.edit(true)

t.keyboard(:press) do |native_event|
  event = Native(native_event)
  puts "press : #{event[:key]} :  #{event[:keyCode]}"
end

t.keyboard(:down) do |native_event|
  event = Native(native_event)
  if event[:keyCode].to_s == '13'
    event.preventDefault()
    t.color(:red)
  end

end

t.keyboard(:up) do |native_event|
  event = Native(native_event)
  puts "up!!"
end

t.keyboard(true) do |native_event|
  event = Native(native_event)
  puts " true => #{event[:keyCode]}"
  puts "true => #{event[:key]}"

end

# t.keyboard(:input) do |native_event|
#   event = Native(native_event)
#   puts event
# end

# t.keyboard(:keydown) do |native_event|
#   event = Native(native_event)
#   puts "down : #{event[:keyCode]}"
# end

c = circle({ top: 123, left: 0, width: 55, height: 55 })
# c2 = circle({ top: 123, left: 80, width: 55, height: 55 })
# c3 = circle({ top: 123, left: 150, width: 55, height: 55 })

c.touch(true) do
  text({ data: 'stop up', top: 150 })
  t.keyboard({ remove: :up })
end
# c2.touch(true) do
#   text({ data: 'remove all', top: 150 })
#   t.keyboard(:remove)
# end
# c3.touch(true) do
#   t.edit(false)
#   text({ data: 'stop editing', top: 150 })
# end


# b33=box({left: 99, top: 99})
#
# b33.touch(true) do
#   t.keyboard({ remove: :up }) do
#     event = Native(native_event)
#     puts "heyeeee up!!"
#   end
# end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "edit",
    "keyboard",
    "left",
    "preventDefault",
    "touch"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "edit": {
    "aim": "The `edit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `edit`."
  },
  "keyboard": {
    "aim": "The `keyboard` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `keyboard`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "preventDefault": {
    "aim": "The `preventDefault` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `preventDefault`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
