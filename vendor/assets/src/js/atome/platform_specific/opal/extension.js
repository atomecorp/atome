// function atome_js_eval(val){
//     // eval(val);
//
//     var base = "alert('kool')";
//    // var cleanSstr= val.toString()
//
//
//
//     if (base === val) {
//         console.log("Les chaînes sont égales.");
//     } else {
//         console.log("Les chaînes ne sont pas égales.");
//     }
//      eval(val);
// }
//
// alert('opal ready');

function call_ruby_method(string_to_eval){
    Opal.eval(string_to_eval);
}