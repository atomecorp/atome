const atomeDrag = {
    drag: function (options,atome_id,atome) {
        let element = document.getElementById(atome_id)
        const position = {x: 0, y: 0}
        interact(element).draggable({
            listeners: {
                start(event) {

                },
                move(event) {
                    position.x += event.dx
                    position.y += event.dy
                    //  we feed the callback method below
                    atome.drag_move_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);

                    if (options == true){
                        event.target.style.transform =
                            event.target.style.transform = 'translate(' + position.x + 'px, ' + position.y + 'px)'
                    }

                },
                end(event) {
                    alert('end')

                },
            }
        })

    },

    start: function (options,atome_id,atome) {
        let element = document.getElementById(atome_id)
        const position = {x: 0, y: 0}
        interact(element).draggable({
            listeners: {
                start(event) {
                    console.log("kool");
                },

            }
        })

    },

    inertia: function  (options,atome_id,atome){
        let element = document.getElementById(atome_id)
        interact(element).draggable({
            inertia: true
        })
    },

    lock: function  (options,atome_id,atome){
        let element = document.getElementById(atome_id)
        interact(element).draggable({
            startAxis: 'xy',
            // lockAxis: 'start',
            lockAxis: 'x'
        });
    },

    remove: function  (options,atome_id,atome){
        let element = document.getElementById(atome_id)
        interact(element).draggable(false) ;
    },

    snap: function (options,atome_id,atome) {
        let element = document.getElementById(atome_id)
        let x = 0; let y = 0
        interact(element)
            .draggable({
                modifiers: [
                    interact.modifiers.snap({
                        targets: [
                            interact.snappers.grid({ x: 130, y: 30 })
                        ],
                        range: Infinity,
                        relativePoints: [ { x: 0, y: 0 } ]
                    }),
                ],
            })
    },

    constraint: function (options,atome_id,atome) {
        let element = document.getElementById(atome_id)
        let x = 0; let y = 0
        interact(element)
            .draggable({
                modifiers: [
                    interact.modifiers.restrict({
                        restriction: { top: 330, left: 30, bottom: 30, right: 1 },
                        // restriction: element.parentNode,
                        elementRect: { top: 0, left: 0, bottom: 1, right: 1 },
                        // endOnly: false
                    })
                ],
            })
    }

}
