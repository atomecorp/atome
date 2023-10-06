// var checkInterval = setInterval(function () {
//     if (typeof rubyVM !== "undefined") {
//         clearInterval(checkInterval); // Arrêtez la vérification une fois rubyVM trouvé
//         rubyVM.eval('text("rubyvm is ready")');
//     }
// }, 100);

function rubyVMCallback(stringToEval) {
    rubyVM.eval(stringToEval);
}
