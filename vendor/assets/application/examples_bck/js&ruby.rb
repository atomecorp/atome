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