const atomeOver = {

    over_enter: function ( atome_id, atome, proc_passed) {
        let element = document.getElementById(atome_id)
        // let dropzone = document.getElementById('dropzone');
        element.addEventListener('dragover', handleDragOver);

        function handleDragOver(evt) {
            evt.preventDefault();
            atome.$enter_action_callback(proc_passed);
        }

        // mouse_interaction(element, atome)


    },
    over_leave: function ( atome_id, atome,proc_passed) {
        let element = document.getElementById(atome_id)
        // let dropzone = document.getElementById('dropzone');
        element.addEventListener('dragover', handleDragOver);

        function handleDragOver(evt) {
            evt.preventDefault();
            atome.$leave_action_callback(proc_passed);
        }

        // mouse_interaction(element, atome)


    },


}

