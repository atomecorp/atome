

/////////////////////////// connection ws

//
// function connect(address) {
//
//     websocket = new WebSocket(address);
//
//     websocket.onopen = function (event) {
//         rubyVMCallback("puts 'Connected to WebSocket'")
//
//     };
//
//     websocket.onmessage = function (event) {
//         // rubyVMCallback("puts 'object ruby callback : " + event.data + "'")
//     };
//
//     websocket.onclose = function (event) {
//         rubyVMCallback("puts 'WebSocket closed'")
//     };
//
//     websocket.onerror = function (event) {
//         // to prevent error disturbing the console
//         event.preventDefault();
//         console.log('connection lost!')
//     };
//
// }


// function controller_message(msg) {
//     // let json_msgs = JSON.parse(msg);
//     rubyVMCallback("A.receptor("+msg+")")
// }