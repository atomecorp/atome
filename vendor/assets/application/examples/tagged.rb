# frozen_string_literal: true

b=box
b.circle({left: 0, top: 0, tag: {group: :to_grid}})
b.box({left: 120, top: 120, tag: {group: :from_grid}})
b.circle({left: 240, top: 240,  tag: {group: :from_grid}})
b.box({left: 330, top: 330,tag: {group: :to_grid}})
b.box({left: 330, top: 600,tag: :no_tag})


wait 1 do
  tagged(:group).each do |atome_id|
    grab(atome_id).color(:green)
    wait 1 do
      tagged({group: :to_grid }).each do |atome_id|
        grab(atome_id).color(:blue)
      end
    end
  end
end





def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "circle"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  }
}
end
