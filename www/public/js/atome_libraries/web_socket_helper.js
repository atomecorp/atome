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

        this.webSocket.onmessage = function (messageEvent) {
            const data = JSON.parse(messageEvent.data);
            if (data.type === "response") {
                const callback = self.callbacks[data.request_id];
                callback.$response(data);
            } else if (data.type === "code") {
                Opal.eval(data.content);
            } else if (data.type === "read") {
                // alert("read from websocket : "+data.content);
                Opal.Atome.$text(data.content);

            } else {
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