class UserRecognition {
    constructor(language,proc) {
       // var  language='fr-FR';
        window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        const start_recognition = new SpeechRecognition();
        this.recognition=start_recognition;
        start_recognition.continuous = true;
        start_recognition.interimResults = true;
        start_recognition.lang = language;
        start_recognition.addEventListener('result', e => {
            const transcript = Array.from(e.results)
                .map(result => result[0])
                .map(result => result.transcript)
                .join('');
            Opal.JSUtils.$speech_recognition_callback(transcript,proc);
        });
        this.recognition.start();
    }
}


