function rubyVMCallback(method, stringToEval) {
    let ruby_messsage = `${method} '${stringToEval}'`
    Opal.eval(ruby_messsage);
}