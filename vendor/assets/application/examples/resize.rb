# frozen_string_literal: true

m = shape({ id: :the_shape, width: 333, left: 130, top: 30, right: 100, height: 399, smooth: 8, color: :yellowgreen, })
m.drag(true)
m.on(:resize) do |event|
  puts event[:dx]
end

m.resize({ size: { min: { width: 90, height: 190 }, max: { width: 300, height: 600 } } }) do |event|
  puts "width is  is #{event[:rect][:width]}"
end

t=text({data: ' click me to unbind resize'})
t.touch(true) do
  t.data('resize unbinded')
  m.resize(:remove)
end

c=circle({left: 99, top: 99, right: 100, height: 99})

c.touch(true) do
  m.resize({ size: { min: { width: 90, height: 190 }, max: { width: 300, height: 600 } } }) do |event|
    puts "ooooooo"
  end
  m.on(:resize) do |event|
    puts 'yes'
  end
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "data",
    "drag",
    "on",
    "resize",
    "touch"
  ],
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "drag": {
    "aim": "The `drag` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drag`."
  },
  "on": {
    "aim": "The `on` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `on`."
  },
  "resize": {
    "aim": "The `resize` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `resize`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
