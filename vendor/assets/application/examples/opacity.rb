# frozen_string_literal: true

image({id: :planet,path: 'medias/images/red_planet.png', width: 66,height: 66,  left: 33, top: 33})
b=box({width: 66, height: 66, color: :yellowgreen})

  wait 1 do

    b.opacity(0.3)
  end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "3",
    "opacity",
    "png"
  ],
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "opacity": {
    "aim": "The `opacity` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `opacity`."
  },
  "png": {
    "aim": "The `png` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `png`."
  }
}
end
