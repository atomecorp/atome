# frozen_string_literal: true

b = box

16.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45), top: 0, category: :matrix })
end


Universe.user_atomes.each do |atome_id|
  atome_found = hook(atome_id)
  if atome_found.type == :shape
    atome_found.color(:orange)
    atome_found.smooth(200)
    atome_found.top(200)
  end
end

random_found =Universe.user_atomes.sample(7)
random_found.each do |atome_id|
  atome_found = hook(atome_id)
  if atome_found.type == :shape
    atome_found.top(rand(600))
    atome_found.width(rand(120))
    atome_found.height(rand(120))
    atome_found.smooth(rand(120))
    atome_found.color(:red)
  end
end

random_found =Universe.user_atomes.sample(9)
random_found.each do |atome_id|
  atome_found = hook(atome_id)
  if atome_found.type == :shape
    atome_found.left(rand(700))
    atome_found.width(rand(120))
    atome_found.height(rand(120))
    atome_found.smooth(rand(120))
    atome_found.color(:blue)
  end
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "duplicate",
    "each",
    "height",
    "left",
    "smooth",
    "times",
    "top",
    "type",
    "user_atomes",
    "width"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "duplicate": {
    "aim": "The `duplicate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `duplicate`."
  },
  "each": {
    "aim": "The `each` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `each`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "smooth": {
    "aim": "Applies smooth transitions or rounded edges to an object.",
    "usage": "Use `smooth(20)` to apply a smooth transition or corner rounding of 20 pixels."
  },
  "times": {
    "aim": "The `times` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `times`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  },
  "type": {
    "aim": "The `type` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `type`."
  },
  "user_atomes": {
    "aim": "The `user_atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `user_atomes`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
