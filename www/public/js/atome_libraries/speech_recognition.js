class UserRecognition {
    constructor() {
        window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        const start_recognition = new SpeechRecognition();
        this.recognition=start_recognition
        start_recognition.continuous = true;
        start_recognition.interimResults = true;
        start_recognition.lang = 'fr-FR';
        start_recognition.addEventListener('result', e => {
            const transcript = Array.from(e.results)
                .map(result => result[0])
                .map(result => result.transcript)
                .join('');
            console.log(transcript);
        });
    }
}

speechAnalysis =new UserRecognition
$("#stoper").click(function(){
    speechAnalysis.recognition.start();
});