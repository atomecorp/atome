window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
const recognition = new SpeechRecognition();
var recognizing = false;
recognition.continuous = true;
recognition.interimResults = true;
recognition.lang = 'fr-FR';

recognition.addEventListener('result', e => {
    const transcript = Array.from(e.results)
        .map(result => result[0])
        .map(result => result.transcript)
        .join('');
    console.log(transcript);

});
recognition.onstart = function () {
    recognizing = true;
};

recognition.onend = function () {
    recognizing = false;
};

recognition.onerror = function (event) {
    recognizing = false;
};

// $("#stoper").click(function(){
//     if (recognizing) {
//         recognition.stop();
//     }
//     else {
//         {
//             recognition.start();
//         }
//     }
// });