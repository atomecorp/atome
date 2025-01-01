# frozen_string_literal: true

# JS to ruby example & ruby to js example

def my_ruby_meth(val)
  puts "=> rb_meth call from js: #{val}"
end


if Atome::host.to_s == 'web-opal'
  JS.eval("my_opal_js_fct('js fct call with an eval')")
  JS.global.my_opal_js_fct('js fct call directly')
elsif Atome::host.to_sym  == :pure_wasm
  JS.eval("my_ruby_wasm_js_fct('js fct call with an eval')")
end


"js code is in  js/atome/atome.js"
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "eval",
    "global",
    "js",
    "to_s",
    "to_sym"
  ],
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "global": {
    "aim": "The `global` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `global`."
  },
  "js": {
    "aim": "The `js` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `js`."
  },
  "to_s": {
    "aim": "The `to_s` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_s`."
  },
  "to_sym": {
    "aim": "The `to_sym` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_sym`."
  }
}
end
