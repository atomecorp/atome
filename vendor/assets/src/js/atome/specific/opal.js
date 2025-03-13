function atomeJsToRuby(rubycode) {
    Opal.eval(rubycode);
}


function controller_message(msg) {
    Opal.Object.$receptor(msg);
}


function loadApplicationJs() {
    var script = document.createElement("script");
    script.src = "js/application.js";

    script.onload = function () {
        atomeJsToRuby("Universe.allow_sync = true"); //run on callback
        atomeJsToRuby("init_database");
    };

    document.body.appendChild(script);
    // atomeJsToRuby("Universe.allow_sync = true");

}

window.addEventListener('load', function () {
    atomeJsToRuby('atome_genesis');
})


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
            console.log('websocket initialised : '+server)
            // now new can exec user code : loadApplicationJs in index.html
            loadApplicationJs();
            // atomeJsToRuby("A.user_login");
        };
        this.websocket.onmessage = function (event) {
            Opal.eval("Atome.server_receiver(" + event.data + ")");
            // Opal.Atome.$server_receiver(event.data);
        };

        this.websocket.onclose = function (event) {
            console.log("puts 'WebSocket closed'")

        };

        this.websocket.onerror = function (event) {
            // to prevent error disturbing the console
            event.preventDefault();
            console.log('connection lost!')
        };

    },
    ws_sender: function (message) {
        // now we send the data to the server
        // console.log(message);
        this.websocket.send(message)
    },
}


function my_ruby_wasm_js_fct(val) {
    Opal.eval("my_ruby_meth('ruby wasm eval: " + val + "')");
}

function replaceSVGContent(svgPath, target, atomeId) {
    fetch(svgPath)
        .then(response => response.text())
        .then(data => {
            // Opal.eval("A.handleSVGContent('"+data+"', '"+target+"')") ;
            Opal.Atome.$handle_svg_content(data, target, atomeId);
        })
        .catch(error => console.error('Erreur de chargement du SVG :', error));

}