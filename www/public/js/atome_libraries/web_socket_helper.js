class WebSocketHelper {
    constructor(serverAddress) {
        //TODO: Switch to wss once a certificate created.
        this.serverAddress = 'ws://' + serverAddress;
        this._reconnect = true;

        this.webSocket = new WebSocket(this.serverAddress);
        const self = this;

        this.webSocket.onopen = function(event) {
        };

        this.webSocket.onmessage = function(messageEvent) {
            Opal.eval(messageEvent.data);
        };

        this.webSocket.onerror = function(event) {
        };

        this.webSocket.onclose = function(closeEvent) {
            if(self._reconnect) {
                setTimeout(() => self.connect(self.serverAddress), 3000);
            }
        };
    }

    sendMessage(type, message) {
        let messageEnvelope = {
            type: type,
            text: message
        };
        this.webSocket.send(JSON.stringify(messageEnvelope));
    }

    close() {
        this._reconnect = false;
        this.webSocket.close();
    }
}