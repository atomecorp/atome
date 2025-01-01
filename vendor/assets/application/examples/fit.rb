# frozen_string_literal: true

c = circle({ height: 400, width: 200, top: 100, left: 0, top: 100 })
b = c.box({ width: 200, height: 100, left: 600, top: 200, id: :my_box })
c.circle({ width: 200, height: 100, left: 120, top: -80, id: :my_text, data: :hi })
b.circle({ color: :yellow, width: 55, height: 88, left: 100 })
b.box
i=c.image({path: 'medias/images/red_planet.png', id: :the_pix })
# b.text(:red_planet)

wait 1 do

  c.fit({ value: 100, axis: :x })

  wait 1 do
    c.fit({ value: 66, axis: :y })
    wait 1 do
      c.fit({ value: 600, axis: :x })
    end
  end
end
# alert i.width
# alert i.height
# i.fit({ value: 66, axis: :x })
#  i.width(66)
#  i.height(66)

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "circle",
    "fit",
    "height",
    "image",
    "png",
    "text",
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
  "fit": {
    "aim": "The `fit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fit`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "image": {
    "aim": "The `image` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `image`."
  },
  "png": {
    "aim": "The `png` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `png`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
