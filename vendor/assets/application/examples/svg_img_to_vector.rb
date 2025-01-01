# frozen_string_literal: true

grab(:black_matter).image({ path: 'medias/images/icons/color.svg', id: :atomic_logo, width: 33, left: 333 })
img=vector({ width: 333, height: 333, id: :my_placeholder })
A.fetch_svg({ source: :atomic_logo, target: :my_placeholder })
wait 2 do
  img.color(:cyan)
end
# grab(:atomic_logo).delete(true)

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "fetch_svg",
    "svg"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "fetch_svg": {
    "aim": "The `fetch_svg` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fetch_svg`."
  },
  "svg": {
    "aim": "The `svg` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `svg`."
  }
}
end
