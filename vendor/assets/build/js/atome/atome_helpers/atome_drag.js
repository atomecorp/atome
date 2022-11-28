const atomeDrag = {
    drag: function (options,atome_id,atome, proc) {
        const position = {x: 0, y: 0}
        interact('#' + atome_id).draggable({
            inertia: true,
            listeners: {
                start(event) {

                },
                move(event) {
                    position.x += event.dx
                    position.y += event.dy
                    // we feed the callback method below
                    atome.$drag_callback(event.pageX, event.pageY, event.rect.left, event.rect.top,  proc);
                    event.target.style.transform =
                        event.target.style.transform = 'translate(' + position.x + 'px, ' + position.y + 'px)'
                },
            }
        })
    }
}
