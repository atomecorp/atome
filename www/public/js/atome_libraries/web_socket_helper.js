// class WebSocketHelper {
//     constructor(serverAddress, login, password, socketEventListener) {
//         //TODO: Switch to wss once a certificate created.
//         this.serverAddress = 'ws:' + serverAddress;
//         this.login = login;
//         this.password = password;
//         this._reconnect = true;
//         this.socketEventListener = socketEventListener;
//
//     }
//
//     connect() {
//         this.webSocket = new WebSocket(this.serverAddress);
//         const self = this;
//
//         this.webSocket.onopen = function(event) {
//             //Do not let client know that socket is opened until user is authenticated by server.
//             self.webSocket.send('{ "connection": { "username":"' + self.login + '", "password":"' + self.password + '"}}');
//         };
//
//         this.webSocket.onmessage = function(messageEvent) {
//             //Check if server respond to a connect request sent by this helper or to a standard message.
//             const messageData = messageEvent.data;
//             try {
//                 const data = JSON.parse(messageData);
//
//                 if(data.connection != null) {
//                     const connection = data.connection;
//                     if(connection.accepted) {
//                         //Inform client that socket is now connected.
//                         self.socketEventListener.onConnected(connection.username);
//                     } else {
//                         self.socketEventListener.onConnectFailed(connection.username);
//                     }
//                 } else {
//                     //Send message data back to client.
//                     self.socketEventListener.onMessage(data.action);
//                 }
//             } catch(e) {
//                 //Send message back to client when parse error.
//                 self.socketEventListener.onError(messageEvent);
//             }
//         };
//
//         this.webSocket.onerror = function(event) {
//             self.socketEventListener.onError(event);
//         };
//
//         this.webSocket.onclose = function(closeEvent) {
//             if(self._reconnect) {
//                 self.socketEventListener.onReconnect(closeEvent);
//                 setTimeout(() => self.connect(self.serverAddress), 3000);
//             } else {
//                 self.socketEventListener.onClosed(closeEvent);
//             }
//         };
//     }
//
//     sendMessage(message) {
//         this.webSocket.send(message);
//     }
//
//     close() {
//         this._reconnect = false;
//         this.webSocket.close();
//     }
// }
//
// class Messenger{
//     verif(val){
//         alert(val);
//     }
// }


$.getScript('js/dynamic_libraries/opal/opal_parser.js', function (data, textStatus, jqxhr) {});

// const serverAddress = '127.0.0.1:9292';
var activeFlow = new WebSocket('ws://' + window.location.host + window.location.pathname);
// var activeFlow = new WebSocket('ws://' + serverAddress);
activeFlow.onopen    = function()  {
};
activeFlow.onclose   = function()  {
    // bidirectionalFlowContent('websocket closed');
},
activeFlow.onmessage = function(m) {
    Opal.eval(m.data);
};

function send_message(type,message){
    var msg = {
        type: type,
        text: message,
        // id:   "clientID",
        // password: "ç§fd!èx§dfg",
        // date: Date.now()
    };
    // Send the msg object as a JSON-formatted string.
    activeFlow.send(JSON.stringify(msg));
}