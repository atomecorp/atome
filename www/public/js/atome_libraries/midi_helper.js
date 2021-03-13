// class MidiHelper {
//     constructor(params) {
//         WebMidi.enable(function (err) {
//             if (err) {
//                 // console.log("WebMidi could not be enabled.", err);
//                 // document.write("bad")
//             } else {
//                 console.log("WebMidi enabled!");
//                 console.log(WebMidi.inputs);
//                 console.log(WebMidi.outputs);
//                 //document.write(WebMidi.inputs[7]["manufacturer"])
//                 //document.write(WebMidi.outputs)
//                 // document.write("<br>------------<br>")
//
//                 // for(interfaceName of WebMidi.outputs){
//                 //     // document.write(interfaceName["name"]+"<br>")
//                 // }
//                 var output = WebMidi.outputs[4];
//                 // output.playNote("C3")
//
//                 // function start(){
//                 //     output.playNote("C3", 15);
//                 // }
//                 function stop() {
//                     output.stopNote("C3", 15);
//                 }
//
//                 // setTimeout(start, 2000);
//                 output.playNote("C3", 15);
//
//                 setTimeout(stop, 1000);
//             }
//         });
//         return "midi verified";
//     }
//
// }

var interfaces_out = []
var interfaces_in = []
var input;
var output;
WebMidi.enable(function (err) {
    if (err) {
        // console.log("WebMidi could not be enabled.", err);
        // document.write("bad")
    } else {
        // console.log("WebMidi enabled!");
        // console.log(WebMidi.inputs);
        // console.log(WebMidi.outputs);
        //document.write(WebMidi.inputs[7]["manufacturer"])
        //document.write(WebMidi.outputs)
        // document.write("<br>------------<br>")
        // interfaces =WebMidi.outputs
        for (interfaceName of WebMidi.outputs) {
            // console.log(interfaceName["name"]+"<br>");
            interfaces_out.push(interfaceName["name"]);
        }
        for (interfaceName of WebMidi.inputs) {
            // console.log(interfaceName["name"]+"<br>");
            interfaces_in.push(interfaceName["name"]);
        }
        output = WebMidi.outputs[13];

        // output.playNote("C3")


    }
});
function midi_inputs(){
    return interfaces_in;
}

function midi_outputs(){
    return  interfaces_out;
}
function midi_play(note, channel, options) {
    options= options.$to_n();
    output.playNote(note, channel, options);
}

function midi_stop(note, channel, options) {
    options= options.$to_n();
    output.stopNote(note, channel, options);
}

// function midi(params) {
//     function start() {
//         output.playNote("C3", 15);
//     }
//
//     function stop() {
//         output.stopNote("C3", 15);
//     }
//     setTimeout(start, 0.1);
//     setTimeout(stop, 500);
//     return [interfaces_in, interfaces_out];
// }


// WebMidi.enable(function (err) {
//     if (err) {
//         // console.log("WebMidi could not be enabled.", err);
//         // document.write("bad")
//     } else {
//         console.log("WebMidi enabled!");
//         console.log(WebMidi.inputs);
//         console.log(WebMidi.outputs);
//         //document.write(WebMidi.inputs[7]["manufacturer"])
//         //document.write(WebMidi.outputs)
//         // document.write("<br>------------<br>")
//         for(interfaceName of WebMidi.outputs){
//             document.write(interfaceName["name"]+"<br>")
//         }
//         var output = WebMidi.outputs[4];
//         // output.playNote("C3")
//
//         function start(){
//             output.playNote("C3", 15)
//         }
//         function stop(){
//             output.stopNote("C3", 15);
//         }
//         setTimeout(start, 0.1);
//         setTimeout(stop, 3000);
//
//     }
// });