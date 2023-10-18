function rubyVMCallback(rubycode) {
    rubyVM.eval(rubycode);
}


// var checkInterval = setInterval(function () {
//     if (typeof rubyVM !== "undefined") {
//         clearInterval(checkInterval); // Arrêtez la vérification une fois rubyVM trouvé
//         rubyVM.eval('text("rubyvm is ready")');
//     }
// }, 100);
//
