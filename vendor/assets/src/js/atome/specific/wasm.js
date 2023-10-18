function rubyVMCallback(rubycode) {
    // let ruby_message = `${method}${stringToEval}`
    // alert(rubycode);
    rubyVM.eval(rubycode);
}



// var checkInterval = setInterval(function () {
//     if (typeof rubyVM !== "undefined") {
//         clearInterval(checkInterval); // Arrêtez la vérification une fois rubyVM trouvé
//         rubyVM.eval('text("rubyvm is ready")');
//     }
// }, 100);
//
