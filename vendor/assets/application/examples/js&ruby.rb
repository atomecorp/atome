# frozen_string_literal: true


# JS to ruby example & ruby to js example

def my_ruby_meth(val)
  alert "kool from rb_meth: #{val}"
end

opal_js_code=<<STR
function my_js_fct(val){
    Opal.eval("my_ruby_meth('"+val+"')");
    Opal.Object.$my_ruby_meth(val);
}
STR


ruby_wasm_js_code=<<STR
function my_js_fct(val){
    rubyVM.eval("my_ruby_meth('"+val+"')");
}
STR



JS.eval("my_js_fct('hello')")
JS.global.my_js_fct('super')




