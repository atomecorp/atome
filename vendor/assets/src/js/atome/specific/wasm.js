// function rubyVMCallback_org(stringToEval) {
//     alert(stringToEval)
//     rubyVM.eval(stringToEval);
// }

function rubyVMCallback(method, stringToEval) {
    let ruby_message = `${method} ${stringToEval}`
    rubyVM.eval(ruby_message);
}



// var checkInterval = setInterval(function () {
//     if (typeof rubyVM !== "undefined") {
//         clearInterval(checkInterval); // Arrêtez la vérification une fois rubyVM trouvé
//         rubyVM.eval('text("rubyvm is ready")');
//     }
// }, 100);
//
