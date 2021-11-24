class WebSocketHelper {
    constructor(serverAddress, socket_type) {
        this.serverAddress = socket_type + '://' + serverAddress;
        this._reconnect = true;
        this.callbacks = {};

        this.webSocket = new WebSocket(this.serverAddress);
        const self = this;
        const sockSock = this.webSocket;
        this.webSocket.onopen = function (event) {
            Opal.Object.$web_state("connected");
/// hack to keep the socket alive
            let timerId = 0;

            function keepAlive(timeout = 2000) {

                if (sockSock.readyState == sockSock.OPEN) {
                    sockSock.send('');
                }
                timerId = setTimeout(keepAlive, timeout);
            }

            keepAlive();
            // function cancelKeepAlive() {
            //     if (timerId) {
            //         clearTimeout(timerId);
            //     }
            // }
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
            } else if (data.type === "read") {
                const type = data.atome;
                const target = data.target;
                const content = data.content;
                const options = data.options;
                var new_content = Opal.hash(content);
                var new_options = Opal.hash(options);
                Opal.Object.$atomic_request(target, new_content, new_options);
            } else if (data.type === "eval") {
                if (data.options == "clear") {
                    Opal.Atome.$clear("view");
                }
                Opal.eval(data.content.content);
                // const type=data.atome;
                // const target=data.target;
                // const content=data.content;
                // const options=data.options;
                // var new_content=Opal.hash(content);
                // var new_options=Opal.hash(options);
                // Opal.Object.$atomic_request(target, new_content, new_options);
            } else if (data.type === "monitor") {
                // const type=data.atome;
                const target = data.target;
                const file = data.file;
                const options = data.options;
                // alert(type);
                var hashed_file = Opal.hash(file);
                var hashed_options = Opal.hash(options);
                Opal.Object.$atomic_request(target, hashed_file, hashed_options);
            } else if (data.type === "atome") {
                const atome = data.atome;
                const target = data.target;
                const content = data.content;
                Opal.Object.$atomic_request(target, content, atome);
            } else if (data.type === "command") {
                // console.log("---------");
                // console.log("the command send is : ");
                // console.log(data);
                // console.log("---------");
                // atome=data.atome;
                // target=data.target;
                // content=data.content;
                // Opal.Object.$atomic_request(target,atome, content);

                // const type=data.atome;
                const target = data.target;
                const content = data.content;
                const options = data.options;
                const atome = data.atome;
                // alert (content);
                // var the_content=Opal.hash(content::content);
                var the_content = {};
                the_content.content = content;
                the_content = Opal.hash(the_content);
                // var the_new_options=Opal.hash(options);
                Opal.Object.$atomic_request(target, the_content, "no");
            } else {
                console.log(data);
            }
        };

        this.webSocket.onerror = function (event) {
            // Opal.Object.$web_state("disconected");
// console.log(event);
            // console.clear();
            // return false;
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
        // alert ("do something here !!");
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