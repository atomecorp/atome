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

// try {
//     nonExistentFunction();
// } catch (error) {
//     console.error(error);
//     // expected output: ReferenceError: nonExistentFunction is not defined
//     // Note - error messages will vary depending on browser
// }


//////////////////////////////////////////////////////////

// function openWebsocket(url){
//
//     try {
//
//         socket = new WebSocket(url);
//         socket.onopen = function(){
//             alert('Socket is now open.');
//         };
//         socket.onerror = function (error) {
//             alert('There was an un-identified Web Socket error');
//         };
//         socket.onmessage = function (message) {
//             alert("Message: %o", message.data);
//         };
//         alert('good');
//     } catch (e) {
//         alert('Sorry, the web socket at "%s" is un-available', url);
//     }
// }
//
// openWebsocket("ws://localhost:8008");
// // See LICENSE for usage information
//
//     // The following lines allow the ping function to be loaded via commonjs, AMD,
//     // and script tags, directly into window globals.
//     // Thanks to https://github.com/umdjs/umd/blob/master/templates/returnExports.js
//     (function (root, factory) { if (typeof define === 'function' && define.amd) { define([], factory); } else if (typeof module === 'object' && module.exports) { module.exports = factory(); } else { root.ping = factory(); }
//     }(this, function () {
//
//         /**
//          * Creates and loads an image element by url.
//          * @param  {String} url
//          * @return {Promise} promise that resolves to an image element or
//          *                   fails to an Error.
//          */
//         function request_image(url) {
//             return new Promise(function(resolve, reject) {
//                 var img = new Image();
//                 img.onload = function() { resolve(img); };
//                 img.onerror = function() { reject(url); };
//                 img.src = url + '?random-no-cache=' + Math.floor((1 + Math.random()) * 0x10000).toString(16);
//             });
//         }
//
//         /**
//          * Pings a url.
//          * @param  {String} url
//          * @param  {Number} multiplier - optional, factor to adjust the ping by.  0.3 works well for HTTP servers.
//          * @return {Promise} promise that resolves to a ping (ms, float).
//          */
//         function ping(url, multiplier) {
//             return new Promise(function(resolve, reject) {
//                 var start = (new Date()).getTime();
//                 var response = function() {
//                     var delta = ((new Date()).getTime() - start);
//                     delta *= (multiplier || 1);
//                     resolve(delta);
//                 };
//                 request_image(url).then(response).catch(response);
//
//                 // Set a timeout for max-pings, 5s.
//                 setTimeout(function() { reject(Error('Timeout')); }, 5000);
//             });
//         }
//
//         return ping;
//     }));
//////////////////////// tests //////////////////////////////////
// var ws_adress='ws://' + window.location.host + window.location.pathname;
var ws_adress = 'ws://5.196.69.103:9292/index';

 $.getScript('js/dynamic_libraries/opal/opal_parser.js', function (data, textStatus, jqxhr) {});
let activeFlow = new WebSocket(ws_adress);
activeFlow.onopen = function () {
};
activeFlow.onclose = function () {
};
activeFlow.onmessage = function (m) {
    Opal.eval(m.data);
};

function send_message(type, message) {
    let msg = {
        type: type,
        text: message,
        // id:   "clientID",
        // password: "ç§fd!èx§dfg",
        // date: Date.now()
    };
    // Send the msg object as a JSON-formatted string.
    activeFlow.send(JSON.stringify(msg));
}