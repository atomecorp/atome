function atomeJsToRuby(rubycode) {
    rubyVM.eval(rubycode);
}

function controller_message(msg) {
    rubyVM.eval(rubycode);
}

// window.addEventListener('load', function () {
//     // Opal.Object.$atome_genesis();
//     atomeJsToRuby('atome_genesis');
// })

const communication = {
    // websocket: null,// websocket init  for server
    // initialize: function () {
    //     this.websocket = new WebSocket('ws://localhost:9292')
    //     // this.websocket = new WebSocket(address);
    //
    //     this.websocket.onopen = function (event) {
    //         rubyVM.eval("puts 'Connected to WebSocket'")
    //     };
    //
    //     this.websocket.onmessage = function (event) {
    //         rubyVM.eval('message', "('" + event.data + "')")
    //     };
    //
    //     this.websocket.onclose = function (event) {
    //         rubyVM.eval("puts 'WebSocket closed'")
    //
    //     };
    //
    //     this.websocket.onerror = function (event) {
    //         // to prevent error disturbing the console
    //         event.preventDefault();
    //         console.log('connection lost!')
    //     };
    // },// Controller for native core
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
    connect: function (type, server, user, pass, atomes, particles) {
        // websocket for server
        this.websocket = new WebSocket(type + '://' + server);
        this.websocket.onopen = function (event) {

            // now new can exec user code : loadApplicationJs in index.html
            loadApplicationJs();
            // rubyVM.eval("A.user_login");
        };
        this.websocket.onmessage = function (event) {
            // console.log(event.data)
            rubyVM.eval("A.server_receiver(" + event.data + ")");
        };

        this.websocket.onclose = function (event) {
            rubyVM.eval("puts 'WebSocket closed'")

        };

        this.websocket.onerror = function (event) {
            // to prevent error disturbing the console
            event.preventDefault();
            console.log('connection lost!')
        };

    },
    ws_sender: function (message) {
        // now we send the data to the server
        // puts "--> message : #{message}"
        this.websocket.send(message)
    },
}


function my_ruby_wasm_js_fct(val){
    rubyVM.eval("my_ruby_meth('ruby wasm eval: "+val+"')");
}
function fetchSVGContent(svgPath, target) {
    fetch(svgPath)
        .then(response => response.text())
        .then(data => {
            rubyVM.eval("Atome.handleSVGContent('"+data+"', '"+target+"')") ;
            // Module.call('handleSVGContent', 'void', ['string'], [data]);
        })
        .catch(error => console.error('Erreur de chargement du SVG :', error));

}
