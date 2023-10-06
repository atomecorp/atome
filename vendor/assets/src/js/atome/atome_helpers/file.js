const file = {


    reader: function(file, atome, proc) {
        fetch('medias/' + file)
            .then(response => response.text())
            .then(text => atome.$read_callback(text, proc))
    }

}


