// class Generator_helper{

   function  say(sentence){
        let utterance = new SpeechSynthesisUtterance(sentence);
        speechSynthesis.speak(utterance);
    }
// }