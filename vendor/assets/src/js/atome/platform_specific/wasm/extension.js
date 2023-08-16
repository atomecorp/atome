// alert('wasm ready');

function call_ruby_method(string_to_eval){
    setTimeout(function(){ rubyVM.eval(string_to_eval); }, 3000);
}