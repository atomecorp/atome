class UserRecognition {
    constructor(language,proc) {
        window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        const recognition = new SpeechRecognition();
        this.recognition=recognition;
        recognition.continuous = true;
        recognition.interimResults = true;
        recognition.lang = language;
        recognition.addEventListener('result', e => {
            const transcript = Array.from(e.results)
                .map(result => result[0])
                .map(result => result.transcript)
                .join('');
            Opal.JSUtils.$speech_recognition_callback(transcript,proc);
        });
        this.recognition.onstart = function () {
            console.log("started");
        };

        this.recognition.onend = function () {
            console.log("stop");
        };

        this.recognition.onerror = function (event) {
            recognition.start();
            console.log(event);
        };
        this.recognition.start();
    }
}


