# frozen_string_literal: true


c = circle({ height: 400, width: 200, top: 100, left: 0, top: 100 })

puts "infos : #{c.infos}"
puts "width : #{c.infos[:width]}"




def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "infos"
  ],
  "infos": {
    "aim": "The `infos` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `infos`."
  }
}
end
