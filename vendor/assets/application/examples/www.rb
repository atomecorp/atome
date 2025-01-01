#  frozen_string_literal: true

b = box

b.www({ path: "https://www.youtube.com/embed/usQDazZKWAk", left: 333 })

Atome.new(
  renderers: [:html], id: :youtube1, type: :www, attach: :view, path: "https://www.youtube.com/embed/fjJOyfQCMvc?si=lPTz18xXqIfd_3Ql", left: 33, top: 33, width: 199, height: 199,

)
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "new",
    "www",
    "youtube"
  ],
  "new": {
    "aim": "The `new` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `new`."
  },
  "www": {
    "aim": "The `www` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `www`."
  },
  "youtube": {
    "aim": "The `youtube` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `youtube`."
  }
}
end
