# frozen_string_literal: true

image({ id: :logo })
def_2 = "M 536.75,-0.25 C 536.75,-0.25 536.75,-0.08 536.75,0.25 536.75,25.82 536.75,1023.75 536.75,1023.75 536.75,1024.08 536.75,1024.25 536.75,1024.25 L 486.75,1024.25 C 486.75,1024.25 486.75,1024.08 486.75,1023.75 486.75,998.18 486.75,0.25 486.75,0.25 486.75,0.24 486.75,-0.2 486.75,-0.2 L 536.75,-0.25 536.75,-0.25 Z M 536.75,-0.25"
vector({ id: :my_svg, top: 33, left: 99, data: { path: { d: def_2, id: :p2, stroke: :red, 'stroke-width' => 3, fill: :green } } })

wait 1 do
  grab(:view).b64_to_tag({ id: 'my_svg', target: :logo })
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "08",
    "18",
    "2",
    "24",
    "25",
    "75",
    "82"
  ],
  "08": {
    "aim": "The `08` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `08`."
  },
  "18": {
    "aim": "The `18` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `18`."
  },
  "2": {
    "aim": "The `2` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `2`."
  },
  "24": {
    "aim": "The `24` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `24`."
  },
  "25": {
    "aim": "The `25` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `25`."
  },
  "75": {
    "aim": "The `75` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `75`."
  },
  "82": {
    "aim": "The `82` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `82`."
  }
}
end
