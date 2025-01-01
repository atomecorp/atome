# frozen_string_literal: true

# add new font face
A.add_text_visual({ path: 'Roboto', name: 'Roboto-Black' })
A.add_text_visual({ path: 'Roboto', name: 'Roboto-Thin' })
A.add_text_visual({ path: 'Roboto', name: 'Roboto-LightItalic' })

# now applying it
first_text=text({ data: :hello, component: { size: 55, visual: 'Roboto-Thin' } })
wait 1 do
  text({ data: :hello, component: { size: 55, visual: 'Roboto-Black' } })
  wait 1 do
    first_text.component({visual: 'Roboto-LightItalic'})
  end
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "add_text_visual",
    "component"
  ],
  "add_text_visual": {
    "aim": "The `add_text_visual` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `add_text_visual`."
  },
  "component": {
    "aim": "The `component` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `component`."
  }
}
end
