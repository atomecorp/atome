// class Generator_helper{

   function  say(sentence, voice){
    // we get the voices list
           voices = window.speechSynthesis.getVoices();
           utterance = new SpeechSynthesisUtterance(sentence);
           utterance.voice = voices[voice];
           speechSynthesis.speak(utterance);
           // helper
       // var number=voice;
       // var lang =voices[voice].lang;
       // var name =voices[voice].name;
    }
