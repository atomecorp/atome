# frozen_string_literal: true


b=box
i=b.image({path: 'medias/images/icons/hamburger.svg'})
wait 2 do
  i.rotate(22)
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "image",
    "rotate",
    "svg"
  ],
  "image": {
    "aim": "The `image` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `image`."
  },
  "rotate": {
    "aim": "The `rotate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `rotate`."
  },
  "svg": {
    "aim": "The `svg` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `svg`."
  }
}
end
