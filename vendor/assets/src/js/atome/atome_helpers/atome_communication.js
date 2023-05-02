const atomeCommunication = {
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
