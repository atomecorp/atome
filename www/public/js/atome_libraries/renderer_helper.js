// // renderer global utils
// function dyn_lib_load(library, id, params) {
//     let achieve = new Promise(function (resolve, reject) {
//         var url = "js/third_parties/rendering_engines/" + library + ".min.js";
//         $.getScript(url, function () {
//             resolve();
//         });
//     });
//     achieve.then(function () {
//         // we have the renderer to renderer list
//         // Opal.Atome.$libraries(library);
//         // now we run the  fabric renderer
//         switch (library) {
//             case 'fabric':
//                 fabric(id, params);
//                 break;
//             case 'three':
//                 three(id, params);
//                 break;
//             default:
//             // console.log(`Sorry, we are out of ${expr}.`);
//         }
//
//     });
// }
//
// // fabric renderer
// const fabric_list = {};
//
// function add_fabric_object(canvas, params) {
//     // first we test if the renderer is ready
//     if ($('#' + canvas).length === 0) {
//         setTimeout(function () {
//             add_fabric_object(canvas, params, false);
//         }, 1);
//
//     } else {
//         // the renderer is ready ! here we go!
//         canvas = fabric_list[canvas];
//         var object;
//         params = params.$to_n();
//         switch (params.type) {
//             case 'circle':
//                 object = new fabric.Circle(params);
//                 break;
//             case 'rect':
//                 object = new fabric.Rect(params);
//                 break;
//             case 'image':
//                 break;
//             default:
//             // console.log(`Sorry, we are out of ${expr}.`);
//         }
//         canvas.add(object);
//     }
// }
//
// function fabric(the_id, params) {
//     var library = "fabric";
//     if (Opal.Atome.$initialised_libraries(library)) {
//         // create canvas
//         var elemClientWidth = window.innerWidth;
//         var elemClientHeight = window.innerHeight;
//
//         $("#view").append("<canvas id='" + the_id + "' width=" + elemClientWidth + " height= " + elemClientHeight + "></canvas>");
//         // lib init
//         // create a wrapper around native canvas element (with id="c")
//         var canvas = new fabric.Canvas(the_id);
//         // we had the canvas to the canvas list
//         fabric_list[the_id] = canvas;
//         $(window).resize(function () {
//             canvas.setWidth(window.innerWidth);
//             canvas.setHeight(window.innerHeight);
//             canvas.calcOffset();
//         });
//
//         ///object creation
//         add_fabric_object("canvas_id", params);
//     } else {
//         // we have the renderer to renderer list
//         Opal.Atome.$libraries(library);
//         dyn_lib_load(library, the_id, params);
//     }
// }
//
// // three renderer
//
// function three(the_id, params) {
//
// }

// renderer global utils
function dyn_lib_load(library, id, params) {
    let achieve = new Promise(function (resolve, reject) {
        var url = "js/third_parties/rendering_engines/" + library + ".min.js";
        $.getScript(url, function () {
            resolve();
        });
    });
    achieve.then(function () {
        // we have the renderer to renderer list
        // Opal.Atome.$libraries(library);
        // now we run the  fabric renderer
        switch (library) {
            case 'fabric':
                fabric(id, params);
                break;
            case 'three':
                three(id, params);
                break;
            default:
            // console.log(`Sorry, we are out of ${expr}.`);
        }

    });
}

// fabric renderer
const fabric_list = {};

function add_fabric_object(canvas, params) {
    alert (params);
    // first we test if the renderer is ready
    if ($('#' + canvas).length === 0) {
        setTimeout(function () {
            add_fabric_object(canvas, params, false);
        }, 1);

    } else {
        // the renderer is ready ! here we go!
        canvas = fabric_list[canvas];
        var object;
        params = params.$to_n();
        switch (params.type) {
            case 'circle':
                object = new fabric.Circle(params);
                break;
            case 'rect':
                object = new fabric.Rect(params);
                break;
            case 'triangle':
                object = new fabric.Circle(params);
                break;
            case 'image':
                break;
            default:
            // console.log(`Sorry, we are out of ${expr}.`);
        }
        canvas.add(object);
    }
}

function fabric(the_id, params) {
    var library = "fabric";
    if (Opal.Atome.$initialised_libraries(library)) {
        // create canvas
        var elemClientWidth = window.innerWidth;
        var elemClientHeight = window.innerHeight;

        $("#view").append("<canvas id='" + the_id + "' width=" + elemClientWidth + " height= " + elemClientHeight + "></canvas>");
        // lib init
        // create a wrapper around native canvas element (with id="c")
        var canvas = new fabric.Canvas(the_id);
        // we had the canvas to the canvas list
        fabric_list[the_id] = canvas;
        $(window).resize(function () {
            canvas.setWidth(window.innerWidth);
            canvas.setHeight(window.innerHeight);
            canvas.calcOffset();
        });

        ///object creation
        add_fabric_object(the_id, params);
    } else {
        // we have the renderer to renderer list
        Opal.Atome.$libraries(library);
        dyn_lib_load(library, the_id, params);
    }
}

// three renderer

function three(the_id, params) {

}