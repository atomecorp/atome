// function rubyVMCallback(method, stringToEval) {
//     let ruby_messsage = `${method} '${stringToEval}'`
//     Opal.eval(ruby_messsage);
// }

function rubyVMCallback(method) {
    // let ruby_message = `${method}${stringToEval}`
    // alert(ruby_message);
    Opal.eval(method);
}
