# frozen_string_literal: true

gen = generator({ id: :genesis, build: {top: 66, copies: 1} })
gen.build({ id: :bundler, copies: 32, color: :red, width: 33, height: 44,  left: 123, smooth: 9, blur: 3, attach: :view })
grab(:bundler_1).color(:blue)



#   Atome.new(
#   { renderers:  [:html], id: :atomix, type: :element, tag: { system: true }, attach: [], fasten: [] }
# )
#
#
# {:id=>:eDen, :type=>:element, :renderers=>[], :tag=>{:system=>true}, :attach=>[], :fasten=>[]}
# {:renderers=>[], :id=>:eDen, :type=>:element, :tag=>{:system=>true}, :attach=>[], :fasten=>[]}
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "build",
    "new"
  ],
  "build": {
    "aim": "The `build` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `build`."
  },
  "new": {
    "aim": "The `new` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `new`."
  }
}
end
