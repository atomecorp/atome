function atomeJsToRuby(rubycode) {
    rubyVM.eval(rubycode);
}

function controller_message(msg) {
    /// use for communication with server
    rubyVM.eval(msg);
}

// document.addEventListener("DOMContentLoaded", function() {
//     // Votre code ici
//     console.log("Le document est prêt !");
//     rubyVM.eval("init_database");
// });

function loadApplicationJs() {
    // setTimeout(function(){
    //     console.log("remove this timeout")
    atomeJsToRuby("Universe.allow_sync = true"); //run on callback
    rubyVM.eval("init_database");
    // }, 2000)

}


const communication = {
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
                rubyVM.eval("response_listener(" + arg.data + ")");
            } catch (error) {
                console.log('no server, unable to receive message')
            }
        } else {

            try {
                window.chrome.webview.addEventListener('message', arg => {
                    // Opal.Object.$response_listener(arg.data)
                    rubyVM.eval("response_listener(" + arg.data + ")");
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
            // console.log("maybe sanitize here : "+event.data)
            try {
                // const sanitizedData = JSON.stringify(event.data);
                rubyVM.eval(`Atome.server_receiver(${event.data})`);
            } catch (error) {
                console.error("Error in rubyVM.eval:", error);
            }
            // rubyVM.eval("Atome.server_receiver(" + event.data + ")");
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


function my_ruby_wasm_js_fct(val) {
    rubyVM.eval("my_ruby_meth('ruby wasm eval: " + val + "')");
}

function replaceSVGContent(svgPath, target, atomeId, normalise) {
    fetch(svgPath)
        .then(response => response.text())
        .then(data => {
            rubyVM.eval("Atome.handle_svg_content('" + data + "', '" + target + "', '" + atomeId + "', '" + normalise + "')");
            // Module.call('handleSVGContent', 'void', ['string'], [data]);
        })
        .catch(error => console.error('Erreur de chargement du SVG :', error));

}
