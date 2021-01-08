class WebSocketHelper {
    constructor(serverAddress, socketEventListener) {
        //TODO: Switch to wss once a certificate created.
        this.serverAddress = 'ws:' + serverAddress;

        this._reconnect = true;

        this.socketEventListener = socketEventListener;
    }

    connect() {
        this.webSocket = new WebSocket(this.serverAddress);
        const self = this;

        this.webSocket.onopen = function(event) {
            self.socketEventListener.onConnected(event);
        };

        this.webSocket.onmessage = function(messageEvent) {
            self.socketEventListener.onMessage(messageEvent);
        };

        this.webSocket.onerror = function(event) {
            self.socketEventListener.onError(event);
        };

        this.webSocket.onclose = function(closeEvent) {
            if(self._reconnect) {
                self.socketEventListener.onReconnect(closeEvent);
                setTimeout(() => self.connect(self.serverAddress), 3000);
            } else {
                self.socketEventListener.onClosed(closeEvent);
            }
        };
    }

    sendMessage(message) {
        this.webSocket.send(message);
    }

    close() {
        this._reconnect = false;
        this.webSocket.close();
    }
}