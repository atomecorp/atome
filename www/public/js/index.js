var eVe = {
    // Application Constructor
    initialize: function () {
        //document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },
    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function () {
        this.receivedEvent('deviceready');
        // $("#click").click(function () {
        //     $.getScript("js/third_parties/opal/opal_parser.js", function (data, textStatus, jqxhr) {
        //         Opal.Object.$box();
        //     });
        // })

    },

    // Update DOM on a Received Event
    receivedEvent: function (id) {
        // var parentElement = document.getElementById(id);
        // var listeningElement = parentElement.querySelector('.listening');
        // var receivedElement = parentElement.querySelector('.received');
        //
        // listeningElement.setAttribute('style', 'display:none;');
        // receivedElement.setAttribute('style', 'display:block;');
        //
        // console.log('Received Event: ' + id);
    }
};

eVe.initialize();

var device = "";
// Libraries
// var promises = 0;
var html = {
    animate: function (value, atome_id) {
        var start = value.start;
        var end = value.end;
        var duration = value.duration;
        var curve = value.curve;
        var property = value.property;
        var finished = value.finished;
        var loop = value.loop;
        var yoyo = value.yoyo;
        var a_start = {};
        var a_end = {};
        var a_duration = {};
        var a_curve = {};
        var a_property = {};
        var a_finished = {};

        if (start === "") {
            start = 0;
        }
        if (end === "") {
            end = 200;
        }

        if (duration === "") {
            duration = 2000;
        }
        if (property === "") {
            property = "x";
        }

        if (curve === "") {
            curve = "Out";
        }

        if (finished === "") {
            finished = "";
        }
        if (loop === "") {
            loop = 0;
        }
        var objectType = Opal.Object.$grab(atome_id).$type();

        // var start_option = Object.keys(value.start);
        if (typeof (start) == "object") {
            var start_opt = Object.keys(value.start);

            start_opt.forEach((item) => {
                key = item;
                val = value.start[item];
                if (key === "background" && objectType === "text") {
                    key = "color";
                }
                a_start[key] = val;
            });
        } else {
            a_start[property] = start;
        }
        // var end_option = Object.keys(value.end);
        if (typeof (end) == "object") {
            var end_option = Object.keys(value.end);
            end_option.forEach((item) => {
                key = item;
                val = value.end[item];
                if (key === "background" && objectType === "text") {
                    key = "color";
                }
                a_end[key] = val;
            });
        } else {
            a_end[property] = end;
        }
        a_duration[property] = duration;
        a_curve[property] = curve;
        a_property[property] = property;
        a_finished[property] = finished;
//////////////////////// popmotion
        var {easing, tween, styler} = window.popmotion;
        var divStyler = styler(document.querySelector('#' + atome_id));
        tween({
            from: a_start,
            to: a_end,
            duration: duration,
            ease: easing[curve],
            flip: loop,
            yoyo: yoyo,

            // complete(alert("good")
        })
            .start(divStyler.set)
    },

};
// upload methods here


// function retry_to_get_the_img_informations(img_width){
//     setTimeout(function(){
//         console.log(("missed but "+img_width));
//     }, 7000	);
// }

// function import_visual_medias(e, file) {
//     // $( "#output" ).remove();
//     // $("body").append('<img id="output" />');
//     // $("#output").css("z-index",50000);
//     // $("#output").css("position","absolute");
//
//     var input = e.target;
//     var reader = new FileReader();
//     reader.onload = function () {
//         var dataURL = reader.result;
//         // alert(dataURL)
//         $('#view').append('<img id="output"  alt="Girl in a jacket" width="500" height="600">');
//         var output = document.getElementById('output');
//         output.src = dataURL;
//         // img_width=document.getElementById('output').width
//         // if (img_width !=0){
//         //     console.log("sucess"+img_width );
//         // }
//         // else {
//         //     retry_to_get_the_img_informations(img_width);
//         // }
//     };
//
//     // Opal.Object.$store(file.name, file);
//
//
//
//     reader.readAsDataURL(file);
// }
//
// function import_audio(e, file) {
//     var input = e.target;
//     var reader = new FileReader();
//     reader.onload = function () {
//         var dataURL = reader.result
//         // var output = document.getElementById('output');
//         //output.src = dataURL;
//     };
//     reader.readAsDataURL(file);
// }
//
// function import_text(e, file) {
//     var textType = /text.*/;
//     if (file.type.match(textType)) {
//         var reader = new FileReader();
//         reader.onload = function (e) {
//             fileDisplayArea.innerText = reader.result;
//         };
//         reader.readAsText(file);
//     }
// }
//
// function upload(e) {
//
//     var files = e.dataTransfer.files
//     // alert(files.length);
//     for (var i = 0; i < files.length; i++) {
//         file_type = files[i].type;
//         file_name = files[i].name;
//         file_datas = files[i].name;
//         console.log(file_datas);
//
//
// ////////////////////////////////////////////////////////////////////////////////////////
//         switch (file_type) {
//             case 'video/quicktime':
//                 import_visual_medias(e, files[i]);
//                 break;
//             case 'video/x-m4v':
//                 import_visual_medias(e, files[i]);
//                 break;
//             case 'text/plain':
//                 import_text(e, files[i]);
//                 break;
//             case 'video/mp4':
//                 import_visual_medias(e, files[i]);
//                 break;
//             case 'audio/x-m4a':
//                 import_audio(e, files[i]);
//                 break;
//             case 'image/png':
//                 import_visual_medias(e, files[i]);
//                 break;
//             case 'image/jpeg':
//                 import_visual_medias(e, files[i]);
//                 break;
//             case 'text/xml':
//                 import_text(e, files[i]);
//                 break;
//             case 'image/svg+xml':
//                 import_visual_medias(e, files[i]);
//                 break;
//             default:
//                 console.log('Unknown file format');
//         }
//     }
// }



// window.ondragover = function (e) {
//     e.preventDefault();
// };
// window.ondrop = function (e) {
//     e.preventDefault(e);
//     alert ('kooll');
//     upload(e);
// };