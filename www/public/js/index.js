var html = {
    animate: function (value, atome_id) {
        let start = value.start;
        let end = value.end;
        let duration = value.duration;
        let curve = value.curve;
        let property = value.property;
        let finished = value.finished;
        let loop = value.loop;
        let yoyo = value.yoyo;
        let a_start = {};
        let a_end = {};
        let a_duration = {};
        let a_curve = {};
        let a_property = {};
        let a_finished = {};

        if (start === "") {
            start = 0;
        }
        if (end === "") {
            end = 200;
        }

        if (duration === "") {
            duration = 2000;
        }
        if (property === "") {
            property = "x";
        }

        if (curve === "") {
            curve = "Out";
        }

        if (finished === "") {
            finished = "";
        }
        if (loop === "") {
            loop = 0;
        }
        const objectType = Opal.Object.$grab(atome_id).$type();

        // var start_option = Object.keys(value.start);
        if (typeof (start) == "object") {
            const start_opt = Object.keys(value.start);

            start_opt.forEach((item) => {
                let key = item;
                const val = value.start[item];
                if (key === "background" && objectType === "text") {
                    key = "color";
                }
                a_start[key] = val;
            });
        } else {
            a_start[property] = start;
        }
        // var end_option = Object.keys(value.end);
        if (typeof (end) == "object") {
            const end_option = Object.keys(value.end);
            end_option.forEach((item) => {
                let key = item;
                const val = value.end[item];
                if (key === "background" && objectType === "text") {
                    key = "color";
                }
                a_end[key] = val;
            });
        } else {
            a_end[property] = end;
        }
        a_duration[property] = duration;
        a_curve[property] = curve;
        a_property[property] = property;
        a_finished[property] = finished;
//////////////////////// popmotion
        const {easing, tween, styler} = window.popmotion;
        const divStyler = styler(document.querySelector('#' + atome_id));
        tween({
            from: a_start,
            to: a_end,
            duration: duration,
            ease: easing[curve],
            flip: loop,
            yoyo: yoyo
        })
            .start(divStyler.set);
    },

};
// upload methods here

function import_visual_medias(e, file) {
    var reader = new FileReader();
    reader.onload = function () {
        const dataURL = reader.result;
        // alert(dataURL)
        $('#view').append('<img id="output"  alt="Girl in a jacket" width="500" height="600">');
        const output = document.getElementById('output');
        output.src = dataURL;
    };

    reader.readAsDataURL(file);
}

function upload(e) {
    const files = e.dataTransfer.files;

    for (let i = 0; i < files.length; i++) {
        let file_type = files[i].type;
        let file_datas = files[i].name;
        console.log(file_datas);

        switch (file_type) {
            case 'video/quicktime':
                import_visual_medias(e, files[i]);
                break;
            case 'video/x-m4v':
                import_visual_medias(e, files[i]);
                break;
            case 'text/plain':
                import_text(e, files[i]);
                break;
            case 'video/mp4':
                import_visual_medias(e, files[i]);
                break;
            case 'audio/x-m4a':
                import_audio(e, files[i]);
                break;
            case 'image/png':
                import_visual_medias(e, files[i]);
                break;
            case 'image/jpeg':
                import_visual_medias(e, files[i]);
                break;
            case 'text/xml':
                import_text(e, files[i]);
                break;
            case 'image/svg+xml':
                import_visual_medias(e, files[i]);
                break;
            default:
                console.log('Unknown file format');
        }
    }
}

function displayImg(url) {
    $('#view').append('<img id="output"  alt="Girl in a jacket" width="500" height="600">');
    const output = document.getElementById('output');
    output.src = url;
}

let webSocketHelper;
let databaseHelper;
let fileHelper;

let webSocketEventListener = {
    onConnected: function(username) {
        console.log('Websocket connected with user ' + username);
        this.sendGreetingsToServer();
    },

    onConnectFailed: function(username) {
        console.log('Connection failed for user ' + username);
    },

    onMessage: function(data) {
        Opal.eval(data);
    },

    onError: function(event) {
        console.log('Web socket error: ' + event.data);
    },

    onReconnect: function(event) {
        console.log('Connection to server lost; reconnecting');
    },

    onClosed: function(event) {
        console.log('Connection to server close successfully');
    },

    sendGreetingsToServer: function() {
        {
            webSocketHelper.sendMessage('{ "action": "box()"}');
        }
    }
};

let databaseEventListener = {
    onConnected: function(event) {
        console.log('Database connected');
        databaseHelper.getAllUsers();
    }
};

let fileSystemPermissionEventListener = {
    onPermissionAccepted: function(fs) {
        console.log('File system permissions accepted');
    },
    onPermissionDenied: function() {
        console.log('File system permissions denied');
        alert('File system permissions denied');
    }
};

document.addEventListener("deviceready", function() {
    //TODO: Get server address from DNS.
    const serverAddress = '192.168.103.147:9292';
    webSocketHelper = new WebSocketHelper(serverAddress, webSocketEventListener, "Régis", "00000000");
    webSocketHelper.connect();
}, false);

document.addEventListener("deviceready", function() {
    databaseHelper = new DatabaseHelper('atome.db', databaseEventListener);
    databaseHelper.connect();
}, false);

document.addEventListener("deviceReady", function() {
    fileHelper = new FileHelper(5 * 1024 * 1024, fileSystemPermissionEventListener);
    fileHelper.connect();
}, false);

window.ondragover = function (e) {
    e.preventDefault();
};

window.ondrop = function (e) {
    e.preventDefault();

    fileHelper.createFile("image.png", e.dataTransfer.files[0], {
        success: function() {
            fileHelper.getUrl("image.png", function (imageUrl) {
                displayImg(imageUrl);
            });
        },
        error: function(fileError) {
            alert('Cannot create file. Reason: ' + fileError);
        }
    });
};