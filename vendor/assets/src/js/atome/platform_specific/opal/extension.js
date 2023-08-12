function atome_js_eval(val){
    // eval(val);

    var base = "alert('kool')";
   // var cleanSstr= val.toString()



    if (base === val) {
        console.log("Les chaînes sont égales.");
    } else {
        console.log("Les chaînes ne sont pas égales.");
    }
     eval(val);
}