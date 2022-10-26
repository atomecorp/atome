class AtomeDrag {
    constructor() {
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
                    start(event) {
//TODO:  optimise this passing the proc to the drag callback
                        // lets get the current atome Object
                        self.current_obj = Opal.Utilities.$grab(event.target.id)
                        // now get the grab proc
                        self.proc_meth = current_obj.$instance_variable_get("@html_drag")
                        // self.proc_meth = proc_found;
                    },
                    // call this function on every dragend event
                    end(event) {

                    }
                }
            })

        function dragMoveListener(event) {
            const target = event.target
            // the code below can be conditioned to receive the drag event without moving the object
            // keep the dragged position in the data-x/data-y attributes
            const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
            const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
            // translate the element
            target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'
            // update the position attributes
            target.setAttribute('data-x', x)
            target.setAttribute('data-y', y)
            // CallBack here
            self.current_obj.$dragCallback(event.pageX, event.pageY,event.rect.left,event.rect.top,self.current_obj, self.proc_meth);
        }
    }

}

// Usage:
let atomeDrag = new AtomeDrag();
atomeDrag.drag();


class Atomeanimation{


}

// TODO: put in a class

const atome = {
    jsSchedule: function (years, months, days, hours, minutes, seconds, proc) {
        const now = new Date();
        const formatedDate = new Date(years, months - 1, days, hours, minutes, seconds);
        const diffTime = Math.abs(formatedDate - now);
        setTimeout(function () {
            Opal.Object.$schedule_callback(proc);
        }, diffTime);
    }}