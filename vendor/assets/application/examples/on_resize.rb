# frozen_string_literal: true

# please note that whatever the atome resize will return the size of the view!
view = grab(:view)
view.on(:resize) do |event|
  puts "view size is #{event}"
end

b=box
b.touch(true) do
  view.on(:remove)
end


c=circle({ left: 333 })

c.touch(true) do
  view.on(:resize) do |event|
    puts "Now size is : #{event}"
  end
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "on",
    "touch"
  ],
  "on": {
    "aim": "The `on` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `on`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
