# frozen_string_literal: true

b=box({ left: 12, id: :the_first_box })
b.touch(true) do

  alt=b.alternate(true, false)
  if alt
    b.color(:green)
  else
    b.color(:red)
  end
  allow_right_touch(alt)

end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "alternate",
    "color",
    "touch"
  ],
  "alternate": {
    "aim": "The `alternate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `alternate`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
