# frozen_string_literal: true


c = circle({ height: 400, width: 200, top: 100, left:99, top: 79 })
b = c.box({ width: 200, height: 100, left: 280, top: 190, id: :my_box })
i= image(:red_planet)
c.touch(true) do
  c.fit({ value: 100, axis: :x })
end

puts '------'
puts "b.compute  left return the position on the screen of the item : #{b.compute({reference: c.id, particle: :left, metrics: :pixel})}"
puts "b.compute left : #{b.compute({ particle: :left })[:value]}, c left : #{b.left}"
puts "b.compute top :#{b.compute({ particle: :top })[:value]}, c top: #{b.top}"
puts  "i.compute width :#{i.compute({ particle: :width })[:value]}, i width: #{i.width}"
puts "i.compute height :#{i.compute({ particle: :height })[:value]}, i height: #{i.height}"

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "compute",
    "fit",
    "height",
    "id",
    "left",
    "top",
    "touch",
    "width"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "compute": {
    "aim": "The `compute` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `compute`."
  },
  "fit": {
    "aim": "The `fit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fit`."
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
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
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
