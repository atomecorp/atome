let fileHelper;
let drawingHelper;
let midiHelper;
let videoHelper;
let audioHelper;
let animationHelper;

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


//AnimationHelper
animationHelper = new AnimationHelper();

//drawingHelper
// drawingHelper = new DrawingHelper(1024, 768, drawingEventListener);

//midiHelper
midiHelper = new MidiHelper(midiEventListener);

//importHelper
importHelper = new ImportHelper();

//videoHelper
videoHelper = new VideoHelper();


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
                    importHelper.addImage('view', imageUrl);
                });
            },
            error: function (fileError) {
                alert('Cannot create file. Reason: ' + fileError);
            }
        });
    }
};

// dynamic loading of js script
// we test ig the server respond, if so we load the websocket library
// var p = new Ping();
// p.ping("https://github.com", function (err, data) {
//     if (err) {
//         server not ready
//     } else {
//         $.getScript("js/atome_libraries/web_socket_helper.js", function () {
//         });
//     }
// });

function message_server(type, message) {
    send_message(type, message);
}

function alarm(date2) {
    const date1 = new Date();
    // const date2 = new Date();
    // const date1 = new Date('7/13/2010');
    // const date2 = new Date('12/15/2010');
    const diffTime = Math.abs(date2 - date1);
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    // alert(diffTime + " milliseconds");
    Opal.Atome.$text(diffTime + " milliseconds");
    console.log(diffDays + " days");
}

// alarm test
// setTimeout(function () {
//     var date = new Date();
//     if (date.getDate() === 24 && date.getHours() === 18 && date.getMinutes === 29) {
//         alert("Surprise!!");
//     }
// }, 1000);

// function verif_alarm(){
//     const now = new Date();
//     alarm("04 2021 18 43 56");
// }

function verif_alarm() {
    // alert(now.getDay());
    const now = new Date();
    setTimeout(function () {
        alarm(now);
        // var new_date=now.toString();
        // var new_date2=now2.toString();
        // var result=new_date+ " : "+new_date2;
        // Opal.Atome.$text(result);
    }, 3000);
}

// verif_alarm();
// const now3 = new Date();
// alert(now3);
