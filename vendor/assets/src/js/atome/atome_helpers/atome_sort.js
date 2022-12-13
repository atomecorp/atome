const atomeSort = {
    sort: function (options, atome_id, atome) {
        let element = document.getElementById(atome_id)
        let children = Array.from(element.children);
        children.forEach((element, _index) => {
            element.style.position = 'relative'
            element.style.webkitUserDrag = 'element'
        })
        Sortable.create(element, {
            animation: 1150,
            ghostClass: 'selected',
            onSort: function () {
                // alert('sorted');
                atome.$sort_callback(atome)

                // sortable({sort: onSort, change:onChange, start:onStart })
            }
        })
    },
}
