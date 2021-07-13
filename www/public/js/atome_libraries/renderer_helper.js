// renderer global utils
function dyn_lib_load(library, datas, id) {
    let achieve = new Promise(function (resolve, reject) {
        var url = "js/third_parties/rendering_engines/" + library + ".min.js";
        $.getScript(url, function () {
            resolve();
        });
    });
    achieve.then(function () {
        // we have the renderer to renderer list
        Opal.Atome.$libraries(library);
        // now we run the  fabric renderer
        eval(library + "('" + datas + "','" + id + "')");
    });
}
// fabric renderer
const  fabric_list={};

function add_fabric_object(canvas, type, params){
    // first we test if the renderer is ready
    if ($('#' +canvas).length===0){
        setTimeout(function () {
            add_fabric_object(canvas, type, params);
        }, 1);
    }
    else{
        // the renderer is ready ! here we go!
        canvas=fabric_list[canvas];
        var object;
        params=params.$to_n();
        // params=Opal.eval(params);
        alert (params.radius);
        switch (type) {
            case 'circle':
                 object = new fabric.Circle({
                    // radius: 16, fill: 'red', left: 200, top: 100
                });
                break;
            case 'rect':
                 object = new fabric.Rect({
                    id: 'myidj',
                    left: 100,
                    top: 100,
                    fill: 'blue',
                    width: 20,
                    height: 20
                });
                break;
            case 'image':
                break;
            default:

                // console.log(`Sorry, we are out of ${expr}.`);
        }
        canvas.add(object);
    }
}

function reportWindowSize() {
    // add to main atome's on_resize method
    canvas.setWidth(window.innerWidth);
    canvas.setHeight(window.innerHeight);
    canvas.calcOffset();
}

function fabric(datas, the_id) {
    var library = "fabric";

    if (Opal.Atome.$initialised_libraries(library)) {
        /// create canvas
        var elemClientWidth = window.innerWidth;
        var elemClientHeight = window.innerHeight;
        $("#view").append("<canvas id='" + the_id + "' width=" + elemClientWidth + " height= " + elemClientHeight + "></canvas>");
/// lib init
        window.addEventListener('resize', reportWindowSize);
        // create a wrapper around native canvas element (with id="c")
        var canvas = new fabric.Canvas(the_id);
        // we had the canvas to the canvas list
        fabric_list[the_id]=canvas;

        ///object creation
        add_fabric_object("canvas_id", 'rect',"radius: 20, fill: 'green', left: 100, top: 100");
//         var circle = new fabric.Circle({
//             radius: 20, fill: 'green', left: 100, top: 100
//         });
// // "add" rectangle onto canvas
//         canvas.add(circle);
//         // alert(fabric_list[the_id]);
//         // alert(fabric_list["canvas_id"]);
    } else {
        dyn_lib_load(library, datas, the_id);
    }
}