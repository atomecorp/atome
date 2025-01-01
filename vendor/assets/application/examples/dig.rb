# frozen_string_literal: true


c = circle({ height: 400, width: 200, top: 100, left: 0, top: 100 , id: :the_circle})
b = c.box({ width: 200, height: 100, left: 600, top: 200, id: :my_box })
c.circle({ width: 200, height: 100, left: 120, top: -80, id: :my_text, data: :hi })
b.circle({ color: :yellow, width: 55, height: 88, left: 100 })
b.box


atome_founds = c.dig
puts "dig allow to retrieve all fasten atomes recursively,
it return a table of ID including the ID of the parent (here : :the_circle) :\n#{atome_founds}"
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "circle",
    "dig"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "dig": {
    "aim": "The `dig` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `dig`."
  }
}
end
