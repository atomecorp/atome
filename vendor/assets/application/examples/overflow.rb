# frozen_string_literal: true

b = box({ id: :the_container, width: 300, height: 300 })
b.box({ top: 500, color: :red })
cc = b.circle({ top: 160, id: :the_circle })

initial_height = cc.height
initial_width = cc.width
b.overflow(:scroll) do |event|
  new_height = initial_height + event[:top]
  cc.height(new_height)
  { left: event[:top] }
end
c = circle({ top: 370, color: :red })
c.touch(:up) do
  b.overflow(:remove)
  c.delete(true)
  c = circle({ top: 370, left: 90, color: :green })
  c.touch(true) do
    b.overflow(:scroll) do |event|
      puts 'removed!!'
      new_width = initial_width + event[:top]
      cc.width(new_width)
    end
  end
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "circle",
    "delete",
    "height",
    "overflow",
    "touch",
    "width"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "overflow": {
    "aim": "The `overflow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `overflow`."
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
