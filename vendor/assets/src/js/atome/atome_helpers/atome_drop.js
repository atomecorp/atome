const atomeDrop = {
    drop: function (options, atome_id, atome) {

        // internal drop cf a div dropped on a div
        let element = document.getElementById(atome_id)
        mouse_interaction(element,atome)

        file_drop(atome_id,atome);
    }

}

