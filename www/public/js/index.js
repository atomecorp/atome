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
    const reader = new FileReader();
    reader.onload = function () {
        const dataURL = reader.result;
        // alert(dataURL)
        const randomId = Math.random().toString(16).substr(2, 32);
        $('#view').append('<img id="' + randomId + '"  alt="Girl in a jacket" width="500" height="600">');
        const output = document.getElementById(randomId);
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
    const randomId = Math.random().toString(16).substr(2, 32);
    $('#view').append('<img id="' + randomId + '"  alt="Girl in a jacket" width="500" height="600">');
    const output = document.getElementById(randomId);
    output.src = url;
}

let webSocketHelper;
let databaseHelper;
let fileHelper;
let drawingHelper;

let webSocketEventListener = {
    onConnected: function (username) {
        console.log('Websocket connected with user ' + username);
        this.sendGreetingsToServer();
    },

    onConnectFailed: function (username) {
        console.log('Connection failed for user ' + username);
    },

    onMessage: function (data) {
        Opal.eval(data);
    },

    onError: function (event) {
        console.log('Web socket error: ' + event.data);
    },

    onReconnect: function (event) {
        console.log('Connection to server lost; reconnecting');
    },

    onClosed: function (event) {
        console.log('Connection to server close successfully');
    },

    sendGreetingsToServer: function () {
        {
            webSocketHelper.sendMessage('{ "action": "text(:hello)"}');
        }
    }
};

let databaseEventListener = {
    onConnected: function (event) {
        console.log('Database connected');
        databaseHelper.getAllUsers();
    }
};

let fileSystemPermissionEventListener = {
    onPermissionAccepted: function (fs) {
        console.log('File system permissions accepted');
    },
    onPermissionDenied: function () {
        console.log('File system permissions denied');
        alert('File system permissions denied');
    }
};

let drawingEventListener = {
    onConnected: function (event) {
        console.log('Drawing connected');
        drawingHelper.setMode(drawingHelper.modeType.Draw);
    }
};

document.addEventListener("deviceready", function () {
    // $.getScript('js/third_parties/opal/opal_parser.js', function (data, textStatus, jqxhr) {
    //     //webSocketHelper
    //     //TODO: Get server address from DNS.
    //     const serverAddress = '192.168.1.13:9292';
    //     webSocketHelper = new WebSocketHelper(serverAddress, "Régis", "00000000", webSocketEventListener);
    //     webSocketHelper.connect();
    // });


    //databaseHelper
    databaseHelper = new DatabaseHelper('atome.db', databaseEventListener);
    databaseHelper.connect();

    //fileHelper
    fileHelper = new FileHelper(5 * 1024 * 1024, fileSystemPermissionEventListener);
    fileHelper.connect(564654);

    //drawingHelper
    // drawingHelper = new DrawingHelper(1024, 768, drawingEventListener);
    // drawingHelper.connect();
}, false);

window.ondragover = function (e) {
    e.preventDefault();
};

window.ondrop = function (e) {
    e.preventDefault();
    if (typeof e.dataTransfer === 'object' && e.dataTransfer !== null) {
        fileHelper.createFile("image.png", e.dataTransfer.files[0], {
            success: function () {
                fileHelper.getUrl("image.png", function (imageUrl) {
                    displayImg(imageUrl);
                });
            },
            error: function (fileError) {
                alert('Cannot create file. Reason: ' + fileError);
            }
        });
    }
};


