// class Generator_helper{

   function  say(sentence){
alert("poil");
        let utterance = new SpeechSynthesisUtterance(sentence);
        speechSynthesis.speak(utterance);
    }
// }