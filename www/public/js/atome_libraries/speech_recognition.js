class UserRecognition {

    constructor(language,proc) {
         self=this;
        window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        const recognition = new SpeechRecognition();
        this.recognition=recognition;
        recognition.continuous = true;
        recognition.interimResults = true;
        recognition.lang = language;
            recognition.addEventListener('result', e => {
                const sentence = Array.from(e.results)
                    .map(result => result[0])
                    .map(result => result.transcript)
                    .join('');
                // const sentence =  e.results[0][0].transcript;
            Opal.JSUtils.$speech_recognition_callback(sentence,proc);

        });

        // this.recognition.stop();
        // this.recognition.start();
        this.recognition.onstart = function () {
            console.log("started");
        };

        this.recognition.onend = function () {
            console.log("stop");
        };

        this.recognition.onerror = function (event) {
            // recognition.start();
            // console.log(event);
        };
        // this.recognition.start();
    }

    start_recognition(){
        self.recognition.start();
    }

    stop_recognition(){
        self.recognition.stop();
    }

}


