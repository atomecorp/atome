const atomeOver = {

    over: function (options, atome_id, atome) {
        let element = document.getElementById(atome_id)
        const position = {x: 0, y: 0}
        interact(element).dropzone({
            listeners: {
                dropactivate: function (event) {
                    // add active dropzone feedback
                    // event.target.classList.add('drop-active')
                },
                dragenter(event) {
                    // console.log(event)
                        atome.$over_action_callback( event.relatedTarget.id);
                    // event.relatedTarget.textContent = 'Dropped'
                },
                dropdeactivate: function (event) {
                    // remove active dropzone feedback
                    // event.target.classList.remove('drop-active')
                    // event.target.classList.remove('drop-target')
                }
                // start(event) {
                //     console.log("satring")
                //     atome.$drag_action_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);
                // },
                // move(event) {
                //     console.log("0000")
                //     position.x += event.dx
                //     position.y += event.dy
                //     //  we feed the callback method below
                //     atome.$drag_action_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);
                //
                //     if (options === true) {
                //         event.target.style.transform =
                //             event.target.style.transform = 'translate(' + position.x + 'px, ' + position.y + 'px)'
                //     }
                //
                // },
                // end(event) {
                //     console.log("endinfring")
                //
                //     atome.$drag_action_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);
                //
                //
                // },
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
