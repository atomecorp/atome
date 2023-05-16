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
                        target = event.target
                        var x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
                        var y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy

                        // translate the element
                        target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'

                        // update the position attributes
                        target.setAttribute('data-x', x)
                        target.setAttribute('data-y', y)


                    }

                },
                end(event) {

                    // We remove the translate and update the position of the atome

                    const transformValue = window.getComputedStyle(element).getPropertyValue('transform');
                    const matrix = transformValue.match(/^matrix\(([^\(]*)\)$/);
                    const transformData = matrix ? matrix[1].split(', ') : null;
                    const translateX = transformData ? parseFloat(transformData[4]) : 0;
                    const translateY = transformData ? parseFloat(transformData[5]) : 0;
                    const positionLeft = element.offsetLeft + translateX;
                    const positionTop = element.offsetTop + translateY;

                    element.style.left = positionLeft+ 'px';
                    element.style.top = positionTop + 'px';
                    // we remove the transform tag
                    element.style.transform = '';
                    // now we reset the interactJS
                    element.setAttribute('data-x', 0)
                    element.setAttribute('data-y', 0)
                    atome.$drag_end_callback(event.pageX, event.pageY, positionLeft, positionTop);

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
// now we reset the position
        var position = element.getBoundingClientRect();
        var transform = element.style.transform;
        var newTransform = transform.replace(/translate\([^\)]*\)/g, "");
        element.style.transform = newTransform;
        element.style.left = position.left + "px";
        element.style.top = position.top + "px";


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
