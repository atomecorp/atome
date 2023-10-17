// function rubyVMCallback_org(stringToEval) {
//     alert(stringToEval)
//     rubyVM.eval(stringToEval);
// }

function rubyVMCallback(method) {
    // let ruby_message = `${method}${stringToEval}`
    // alert(method);
    rubyVM.eval(method);
}



// var checkInterval = setInterval(function () {
//     if (typeof rubyVM !== "undefined") {
//         clearInterval(checkInterval); // Arrêtez la vérification une fois rubyVM trouvé
//         rubyVM.eval('text("rubyvm is ready")');
//     }
// }, 100);
//
