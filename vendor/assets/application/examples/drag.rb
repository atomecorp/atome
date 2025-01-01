#  frozen_string_literal: true

a=box({width: 666, height: 777, color: :orange})
b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2, depth: 1 , top: 66})
cc=circle({color: :red, left: 0, top: 0})
clone = ""
b.drag(:start) do
  b.color(:black)
  b.height(123)
  # beware you must use grab(:view) else it'll be fasten to the context, that means to 'b' in this case
  clone = grab(:view).circle({ color: :white, left: b.left, top: b.top, depth: 3 })
end

b.drag(:stop) do
  b.color(:purple)
  b.height=b.height+100
  clone.delete(true)
end

b.drag(:locked) do |event|
  dx = event[:dx]
  dy = event[:dy]
  x = (clone.left || 0) + dx.to_f
  y = (clone.top || 0) + dy.to_f
  clone.left(x)
  clone.top(y)
  puts "x: #{x}"
  puts "y: #{y}"
end
cc.drag({ restrict: {max:{ left: 240, top: 190}} }) do |event|
end


c=circle

c.drag({ restrict: a.id }) do |event|

end

t=text({data: 'touch me to unbind drag stop for b (clone will not deleted anymore)', left: 250 })
t.touch(true) do
  b.drag({remove: :stop})
end

tt= text({data: "remove drag on circles", top: 99})

tt.touch(true) do
  cc.drag(false)
  c.drag(false)
end



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "delete",
    "drag",
    "height",
    "id",
    "left",
    "to_f",
    "top",
    "touch"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "drag": {
    "aim": "The `drag` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drag`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "to_f": {
    "aim": "The `to_f` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_f`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
