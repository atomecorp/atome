const html = {
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

let databaseHelper;
let fileHelper;
let drawingHelper;
let midiHelper;
let mediaHelper;
let audioHelper;

let databaseEventListener = {
    onConnected: function (event) {
        console.log('Database initialized successfully');
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
    onConnected: function () {
        console.log('Drawing initialized successfully');
        drawingHelper.setMode(drawingHelper.modeType.Draw);
    }
};

let midiEventListener = {
    onConnected: function (event) {
        console.log('Midi initialized successfully!');
    },

    onError: function (event) {
        console.log('Cannot initialize midi!');
    }
};

let mediaEventListener = {
    onConnected: function () {
        console.log('Media initialized successfully');
    },
    onError: function (error) {
        console.log(error);
    }
};

let audioEventListener = {
    onConnected: function (event) {
        console.log('Audio initialized successfully!');
    },

    onError: function (event) {
        console.log('Cannot initialize audio!');
    }
};

document.addEventListener("deviceready", function () {
    //fileHelper
    fileHelper = new FileHelper(5 * 1024 * 1024, fileSystemPermissionEventListener);
}, false);

//drawingHelper
// drawingHelper = new DrawingHelper(1024, 768, drawingEventListener);

//midiHelper
midiHelper = new MidiHelper(midiEventListener);

//mediaHelperrld builds softwa
mediaHelper = new MediaHelper(640, 480, 60, mediaEventListener);
// const previewVideo = mediaHelper.addVideoPlayer('view', 'preview', true);
// const playbackVideo = mediaHelper.addVideoPlayer('view', 'playback', true);
// mediaHelper.connect(previewVideo, playbackVideo);

//audioHelper
audioHelper = new AudioHelper(audioEventListener);

window.ondragover = function (e) {
    e.preventDefault();
};

window.ondrop = function (e) {
    e.preventDefault();
    if (typeof e.dataTransfer === 'object' && e.dataTransfer !== null) {
        fileHelper.createFile("image.png", e.dataTransfer.files[0], {
            success: function () {
                fileHelper.getUrl("image.png", function (imageUrl) {
                    mediaHelper.addImage('view', imageUrl);
                });
            },
            error: function (fileError) {
                alert('Cannot create file. Reason: ' + fileError);
            }
        });
    }
};

const atome = {
    jsIsMobile: function () {
        const a = navigator.userAgent || navigator.vendor || window.opera;
        var mobile = false;
        if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) {
            // true for mobile device
            mobile = "mobile";
        } else {
            // false for not mobile device
            mobile = "desktop";
        }
        return mobile;
    },

    jsReader: function (filename, proc) {
        $.ajax({
            url: filename,
            dataType: 'text',
            success: function (data) {
                return proc.$call(data);
            }
        });
    },
    jsLoadCodeEditor: function (atome_id, content) {
        $('<link/>', {
            rel: 'stylesheet',
            type: 'text/css',
            href: 'css/codemirror.css'
        }).appendTo('head');
        $.getScript('js/third_parties/ide/codemirror.min.js', function (data, textStatus, jqxhr) {
            $.getScript('js/third_parties/ide/active-line.min.js', function (data, textStatus, jqxhr) {
                $.getScript('js/third_parties/ide/closebrackets.min.js', function (data, textStatus, jqxhr) {
                    $.getScript('js/third_parties/ide/closetag.min.js', function (data, textStatus, jqxhr) {
                        $.getScript('js/third_parties/ide/dialog.min.js', function (data, textStatus, jqxhr) {
                            $.getScript('js/third_parties/ide/formatting.min.js', function (data, textStatus, jqxhr) {
                                $.getScript('js/third_parties/ide/javascript.min.js', function (data, textStatus, jqxhr) {
                                    $.getScript('js/third_parties/ide/jump-to-line.min.js', function (data, textStatus, jqxhr) {
                                        $.getScript('js/third_parties/ide/matchbrackets.min.js', function (data, textStatus, jqxhr) {
                                            $.getScript('js/third_parties/ide/ruby.min.js', function (data, textStatus, jqxhr) {
                                                $.getScript('js/third_parties/ide/search.min.js', function (data, textStatus, jqxhr) {
                                                    $.getScript('js/third_parties/ide/searchcursor.min.js', function (data, textStatus, jqxhr) {
                                                        ide_container_id = "#" + atome_id;
                                                        ide_id = 'ide_' + atome_id;
                                                        $(ide_container_id).append("<textarea id=" + ide_id + " name='code'></textarea>");
                                                        var code_editor = CodeMirror.fromTextArea(document.getElementById(ide_id), {
                                                            lineNumbers: true,
                                                            codeFolding: true,
                                                            styleActiveLine: true,
                                                            indentWithTabs: true,
                                                            matchTags: true,
                                                            matchBrackets: true,
                                                            electricChars: true,
                                                            mode: "ruby",
                                                            lineWrapping: true,
                                                            indentAuto: true,
                                                            autoCloseBrackets: true,
                                                            tabMode: "shift",
                                                            autoRefresh: true
                                                        });
                                                        new_editor = document.querySelector(".CodeMirror");
// we check all codemirror if they have an id to avoid to reassign an id to already created codemirror
                                                        if (($(new_editor).attr('id')) == undefined) {
                                                            new_editor_id = "cm_" + atome_id;
                                                            $(new_editor).attr('id', new_editor_id);
                                                        }
                                                        code_editor.setSize("100%", "100%");
                                                        code_editor.setOption("theme", "3024-night");

                                                        function getSelectedRange() {
                                                            return {
                                                                from: editor.getCursor(true),
                                                                to: editor.getCursor(false)
                                                            };
                                                        }

                                                        Opal.JSUtils.$set_ide_content(atome_id, content);
                                                    });
                                                });
                                            });
                                        });
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    }
};


// dynamic loading of js script
// we test ig the server respond, if so we load the websocket library
var p = new Ping();
p.ping("https://github.com", function (err, data) {
    if (err) {
        // server not ready
    } else {
        $.getScript("js/atome_libraries/web_socket_helper.js", function () {
        });
    }
});

function message_server(type, message) {
    send_message(type, message);
}