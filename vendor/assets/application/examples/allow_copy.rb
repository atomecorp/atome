# frozen_string_literal: true


t=text(:hello)
t.edit(true)
b=box({left: 99})

b.touch(true) do
  allow_copy(true)
  allow_right_touch(true)
end



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "edit",
    "touch"
  ],
  "edit": {
    "aim": "The `edit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `edit`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
