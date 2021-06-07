class WebSocketHelper {
    constructor(serverAddress, socket_type) {
        //TODO: Switch to wss once a certificate created.
        this.serverAddress = socket_type + '://' + serverAddress;
        this._reconnect = true;
        this.callbacks = {};

        this.webSocket = new WebSocket(this.serverAddress);
        const self = this;

        this.webSocket.onopen = function (event) {
        };
        var options;
        var target;
        var content;
        this.webSocket.onmessage = function (messageEvent) {
            const data = JSON.parse(messageEvent.data);
            if (data.type === "response") {
                const callback = self.callbacks[data.request_id];
                callback.$response(data);
            } else if (data.type === "code") {
                Opal.eval(data.content);
            }
            else if (data.type === "read") {
                 // atome=data.atome;
                 target=data.target;
                 content=data.content;
                options=data.options;

                var new_content=Opal.hash(content);
                var new_options=Opal.hash(options);
                Opal.Object.$atomic_request(target, new_content, new_options);
            }
            else if (data.type === "atome") {
                 atome=data.atome;
                 target=data.target;
                 content=data.content;
                Opal.Object.$atomic_request(target,atome, content);
            }

            else {
                console.log(data );
            }
        };

        this.webSocket.onerror = function (event) {
        };

        this.webSocket.onclose = function (closeEvent) {
            if (self._reconnect) {
                setTimeout(() => self.connect(self.serverAddress), 3000);
            }
        };
    }

    connect(serverAddress) {
        //fixme: find a way to restore the socket
        console.log("connection lost try ro reconnect");
        // new WebSocketHelper(serverAddress);
    }

    sendMessage(message, callback) {
        this.callbacks[message.request_id] = callback;
        this.webSocket.send(JSON.stringify(message));
    }

    close() {
        this._reconnect = false;
        this.webSocket.close();
    }
}