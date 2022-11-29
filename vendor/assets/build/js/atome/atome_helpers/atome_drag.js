const atomeDrag = {

    drag: function (options, atome_id, atome) {
        let element = document.getElementById(atome_id)
        const position = {x: 0, y: 0}
        interact(element).draggable({
            listeners: {
                start(event) {
                    atome.$drag_start_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);
                },
                move(event) {
                    position.x += event.dx
                    position.y += event.dy
                    //  we feed the callback method below
                    atome.$drag_move_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);

                    if (options === true) {
                        event.target.style.transform =
                            event.target.style.transform = 'translate(' + position.x + 'px, ' + position.y + 'px)'
                    }

                },
                end(event) {
                    atome.$drag_end_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);


                },
            }
        })

    },

    inertia: function (options, atome_id, _atome) {
        let element = document.getElementById(atome_id)
        interact(element).draggable({
            inertia: options
        })
    },

    lock: function (options, atome_id, _atome) {
        let element = document.getElementById(atome_id)
        interact(element).draggable({
            startAxis: 'xy',
            lockAxis: options
        });
    },

    remove: function (options, atome_id, _atome) {
        let element = document.getElementById(atome_id)
        interact(element).draggable(options);
    },

    snap: function (options, atome_id, _atome) {
        let element = document.getElementById(atome_id)
        interact(element)
            .draggable({
                modifiers: [
                    interact.modifiers.snap({
                        targets: [
                            interact.snappers.grid(options),
                        ],
                        range: Infinity,
                        relativePoints: [{x: 0, y: 0}]
                    }),
                ],
            })
    },

    constraint: function (params, atome_id, _atome) {
        let element = document.getElementById(atome_id)
        if ((typeof params) != 'object' && params !== 'parent') {
            params = document.getElementById(params);
        }
        interact(element)
            .draggable({
                modifiers: [
                    interact.modifiers.restrict({
                        restriction: params,
                        elementRect: {top: 0, left: 0, bottom: 1, right: 1},
                        // endOnly: false
                    })
                ],
            })
    }
}
