# frozen_string_literal: true

b=box
b.circle({role: :header, left: 55, id: :first_one})
b.text({role: [:action], data: "hello", top: 90})
b.box({role: :header, left: 155, id: :second_one})


puts"header grip : #{ b.grip(:header)}"
puts "last header grip #{b.grip(:header).last}"

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "circle",
    "grip",
    "text"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "grip": {
    "aim": "The `grip` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `grip`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  }
}
end
