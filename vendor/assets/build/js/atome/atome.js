class AtomeDrag {
    constructor() {
        // proc_found;
        this.toto = "kool";
    }

    drag() {
        // target elements with the "draggable" class
        interact('.draggable')
            .draggable({
                // enable inertial throwing
                inertia: true,
                // keep the element within the area of it's parent
                modifiers: [
                    interact.modifiers.restrictRect({
                        restriction: 'parent',
                        endOnly: true
                    })
                ],
                // enable autoScroll
                autoScroll: true,

                listeners: {
                    // call this function on every dragmove event

                    move: dragMoveListener,
start(event){
//TODO:  optimise this passing the proc to the drag callback
    // lets get the current atome Object
    let current_obj = event.target.id
    // now get the grab proc
     let proc_found = Opal.Utilities.$grab(current_obj).$instance_variable_get("@html_drag")
    // this.proc=proc_found
    // let ok=this.toto
    // alert (ok);
    // let's pass the proc to the dragCallback method
    Opal.Atome.$dragCallback(event.pageX, event.pageY, current_obj, proc_found);

},
                    // call this function on every dragend event
                    end(event) {
                        // var textEl = event.target.querySelector('p')
                        //
                        // textEl && (textEl.textContent =
                        //     'moved a distance of ' +
                        //     (Math.sqrt(Math.pow(event.pageX - event.x0, 2) +
                        //         Math.pow(event.pageY - event.y0, 2) | 0))
                        //         .toFixed(2) + 'px')
                    }
                }
            })

        function dragMoveListener(event) {
// alert(proc_found);

//             alert (event.proc)
            var target = event.target
            // keep the dragged position in the data-x/data-y attributes
            var x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
            var y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy

            // translate the element
            target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'

            // update the posiion attributes
            target.setAttribute('data-x', x)
            target.setAttribute('data-y', y)
// CallBack here
// alert(event.proc)
            // lets get the current atome Object
            let current_obj = event.target.id
            // now get the grab proc
            let proc_found = Opal.Utilities.$grab(current_obj).$instance_variable_get("@html_drag")
            // let's pass the proc to the dragCallback method
            Opal.Atome.$dragCallback(event.pageX, event.pageY, current_obj, proc_found);

        }
    }

}

// Usage:
let atomeDrag = new AtomeDrag();
atomeDrag.drag();