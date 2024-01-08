const communication = {
    // websocket: new WebSocket('ws://localhost:9292'),
    websocket: null,
    initialize: function () {
        this.websocket = new WebSocket('ws://localhost:9292')
        // this.websocket = new WebSocket(address);

        this.websocket.onopen = function (event) {
            rubyVMCallback("puts 'Connected to WebSocket'")
        };

        this.websocket.onmessage = function (event) {
            rubyVMCallback("puts 'object ruby callback : " + event.data + "'")
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
    connect: function (address) {
        this.websocket = new WebSocket(address);

        this.websocket.onopen = function (event) {
            rubyVMCallback("puts 'Connected to WebSocket'")
        };

        this.websocket.onmessage = function (event) {
            rubyVMCallback("puts 'object ruby callback : " + event.data + "'")

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
        this.websocket.send(message)
    },
}

/////////////////////////// connection ws


function connect(address) {

// alert('kool');
    websocket = new WebSocket(address);

    websocket.onopen = function (event) {
        rubyVMCallback("puts 'Connected to WebSocket'")

    };

    websocket.onmessage = function (event) {
        rubyVMCallback("puts 'object ruby callback : " + event.data + "'")
    };

    websocket.onclose = function (event) {
        rubyVMCallback("puts 'WebSocket closed'")
    };

    websocket.onerror = function (event) {
        // to prevent error disturbing the console
        event.preventDefault();
        console.log('connection lost!')
    };

}

// function ws_sender() {
//     websocket.send("the Hello, WebSocket!!!")
// }

