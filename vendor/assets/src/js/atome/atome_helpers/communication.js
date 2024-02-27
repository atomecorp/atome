const communication = {
    websocket: null,
    initialize: function () {
        this.websocket = new WebSocket('ws://localhost:9292')
        // this.websocket = new WebSocket(address);

        this.websocket.onopen = function (event) {
            rubyVMCallback("puts 'Connected to WebSocket'")
        };

        this.websocket.onmessage = function (event) {
            rubyVMCallback('message', "('" + event.data + "')")
        };

        this.websocket.onclose = function (event) {
            rubyVMCallback("puts 'WebSocket closed'")

        };

        this.websocket.onerror = function (event) {
            // to prevent error disturbing the console
            event.preventDefault();
            console.log('connection lost!')
        };
    },
    controller_sender: function (msg) {
        let json_msg = JSON.parse(msg);

        if (window.webkit) {
            try {
                window.webkit.messageHandlers.wkHandler.postMessage(json_msg);
            } catch (error) {
                console.log('no server, unable to post message')
            }

        } else {
            try {
                window.chrome.webview.postMessage(json_msg);
            } catch (error) {
                console.log('no server, unable to post message')
            }
        }
    },
    controller_listener: function () {
        if (window.webkit) {
            try {
                ///
            } catch (error) {
                console.log('no server, unable to receive message')
            }
        } else {

            try {
                window.chrome.webview.addEventListener('message', arg => {
                    Opal.Object.$response_listener(arg.data)
                });
            } catch (error) {
                console.log('no server, unable to receive message')
            }


        }
    },
    connect: function (type, server, user, pass, atomes, particles) {
        this.websocket = new WebSocket(type + '://' + server);
        this.websocket.onopen = function (event) {

            // now new can exec user code : loadApplicationJs in index.html
            loadApplicationJs();
            // rubyVMCallback("A.user_login");
        };
        this.websocket.onmessage = function (event) {
            // console.log(event.data)
            rubyVMCallback("A.server_receiver(" + event.data + ")");
        };

        this.websocket.onclose = function (event) {
            rubyVMCallback("puts 'WebSocket closed'")

        };

        this.websocket.onerror = function (event) {
            // to prevent error disturbing the console
            event.preventDefault();
            console.log('connection lost!')
        };

    },
    ws_sender: function (message) {
        // now we send the data to the server
        // puts "--> message : #{message}"
        this.websocket.send(message)
    },
}

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


function controller_message(msg) {
    // let json_msgs = JSON.parse(msg);
    rubyVMCallback("A.receptor("+msg+")")
}