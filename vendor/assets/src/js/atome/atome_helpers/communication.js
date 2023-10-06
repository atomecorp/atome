const communication = {
    controller_sender: function (msg) {
        var json_msg = JSON.parse(msg);

        if (window.webkit) {
            try {
                window.webkit.messageHandlers.toggleMessageHandler.postMessage(json_msg);
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
}

/////////////////////////// connection ws

function sendWSMessage() {
    if (ws) {
        ws.send("Hello, WebSocket!");
        // displayMessage("Sent: Hello, WebSocket!");
    } else {
        displayMessage("WebSocket is not connected.");
    }
}

function dispatchMessage(message) {
    rubyVMCallback("puts 'ruby callback : " + message + "' ")
}

let websocket;

function connect(value) {


    websocket = new WebSocket(value);

    websocket.onopen = function (event) {
        dispatchMessage("Connected to WebSocket.");
    };

    websocket.onmessage = function (event) {
        dispatchMessage("Received: " + event.data);
    };

    websocket.onclose = function (event) {
        dispatchMessage("WebSocket closed.");
    };


}