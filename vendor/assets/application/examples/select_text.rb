#  frozen_string_literal: true

new({particle: :select})
t = text :hello
t.left(99)

t.edit(true)

b=box
b.touch(true) do
  puts t.data
  back_color = grab(:back_selection)
  text_color = grab(:text_selection)
  back_color.red(1)
  back_color.alpha(1)
  text_color.green(1)
  t.component({ selected: true })
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "alpha",
    "component",
    "data",
    "edit",
    "green",
    "left",
    "red",
    "touch"
  ],
  "alpha": {
    "aim": "The `alpha` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `alpha`."
  },
  "component": {
    "aim": "The `component` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `component`."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "edit": {
    "aim": "The `edit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `edit`."
  },
  "green": {
    "aim": "The `green` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `green`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "red": {
    "aim": "The `red` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `red`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
