# frozen_string_literal: true
puts 'deprecated use clone monitoring'
# b = box({ id: :the_box })
# c = circle({ top: 3, id: :the_cirle })
# A.monitor({ atomes: [:the_box, :the_cirle], particles: [:left] }) do |atome, particle, value|
#   puts "changes : #{atome.id}, #{particle}, #{value}"
# end
#
# wait 2 do
#   b.left(3)
#   wait 2 do
#     c.left(444)
#   end
# end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "id",
    "left",
    "monitor"
  ],
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "monitor": {
    "aim": "The `monitor` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `monitor`."
  }
}
end
