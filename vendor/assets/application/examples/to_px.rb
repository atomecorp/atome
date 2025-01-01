# frozen_string_literal: true



view_width = parent_found.to_px(:width)
view_height = parent_found.to_px(:height)


text({data: "view width in px : #{view_width}, height: #{view_height}" })
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "to_px"
  ],
  "to_px": {
    "aim": "The `to_px` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_px`."
  }
}
end
