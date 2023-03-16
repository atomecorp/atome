const atomeOver = {

    over: function (options, atome_id, atome) {
        let element = document.getElementById(atome_id)
        // let dropzone = document.getElementById('dropzone');
        element.addEventListener('dragover', handleDragOver);

        function handleDragOver(event) {
            event.preventDefault();
            // event.dataTransfer.dropEffect = 'copy';
            element.style.backgroundColor = 'yellow';
            console.log( event.dataTransfer.files);
        }

        mouse_interaction(element, atome)


    }

}

