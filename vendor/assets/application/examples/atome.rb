# frozen_string_literal: true

Atome.new( { renderers: [:html], attach: :view,id: :my_test_box, type: :shape, apply: [:shape_color],
             left: 120, top: 0, width: 100, smooth: 15, height: 100, overflow: :visible, fasten: [], center: true
           })

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "new"
  ],
  "new": {
    "aim": "The `new` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `new`."
  }
}
end
