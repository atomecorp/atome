# frozen_string_literal: true

new ({particle: :trigger})

a=circle
a.trigger({record: true})


### wad JS
bb=box({left: 333})
bb.text(:wadjs)



## Midi test

js_midi_code = <<~JAVASCRIPT
async function startMidi() {
    try {
        await window.__TAURI__.invoke('start_midi');
        console.log('MIDI listener started');
    } catch (error) {
        console.error('Failed to start MIDI listener', error);
    }
}

function listenForMidiEvents() {
    window.__TAURI__.event.listen('midi-event', event => {
        console.log('MIDI Event found:', event.payload);
    });
}

startMidi();
listenForMidiEvents();

JAVASCRIPT
if Atome::host == 'tauri'
  JS.eval(js_midi_code)
end


# Initialize window.snare

init_code = "window.snare = new Wad({source : 'medias/audios/clap.wav'});"
JS.eval(init_code)

# Define the JavaScript playSnare function
js_code = <<~JAVASCRIPT
  window.playSnare = function() {
    window.snare.play();
    // setTimeout(function() {
    //  window.snare.stop();
    //}, 30);
  }
JAVASCRIPT

# Evaluate the JavaScript code once
JS.eval(js_code)

# Define the Ruby method to call the JavaScript function
def play_snare
  JS.eval('window.playSnare()')
end

# Attach the method to the touch event
bb.touch(:down) do
  play_snare
end

synthesis_code = <<~JAVASCRIPT
const synth = window.speechSynthesis;
const utterance1 = new SpeechSynthesisUtterance("Bonjour, comment allez-vous ?");
  utterance1.lang = 'fr-FR';
const utterance2 = new SpeechSynthesisUtterance("hello, how are you ?");
 utterance2.lang = 'en-US';
synth.speak(utterance1);
synth.speak(utterance2);
const utterance3 = new SpeechSynthesisUtterance("Hola, ¿cómo estás?");
utterance3.lang = 'es-ES';
synth.speak(utterance3);
JAVASCRIPT

bcb=box({top: 90})

bcb.touch(true) do
  JS.eval(synthesis_code)
end




######
cbc=box({top: 90, left: 90})
text({data: :result, id: :result, top: 90, left: 190})

recogniction_code = <<~JAVASCRIPT
let recognition;
let recognitionTimeout;

if (!('webkitSpeechRecognition' in window)) {
  alert('Votre navigateur ne supporte pas la Web Speech API.');
  return;
}

recognition = new webkitSpeechRecognition();
recognition.lang = 'fr-FR'; // Langue française
recognition.interimResults = false; // Résultats intérimaires (partiels) désactivés
recognition.maxAlternatives = 1; // Nombre maximum d'alternatives

recognition.onstart = function() {
  console.log('Reconnaissance vocale démarrée.');
};

recognition.onresult = function(event) {
  console.log('Résultat obtenu.');
  const result = event.results[0][0].transcript;
  console.log('Vous avez dit : ' + result);
  document.getElementById('result').innerText = result;
};

recognition.onerror = function(event) {
  console.error('Erreur de reconnaissance vocale : ', event.error);
  switch(event.error) {
    case 'no-speech':
      console.log('Aucune parole détectée.');
      break;
    case 'audio-capture':
      console.log('Microphone non détecté.');
      break;
    case 'not-allowed':
      console.log('Permission de microphone refusée.');
      break;
    default:
      console.log('Erreur inconnue.');
      break;
  }
  clearTimeout(recognitionTimeout); // Annule le timeout en cas d'erreur
};

recognition.onend = function() {
  console.log('Reconnaissance vocale terminée.');
  clearTimeout(recognitionTimeout); // Nettoyage du timeout à la fin de la reconnaissance
};

// Fonction pour démarrer la reconnaissance avec gestion des timeout
function startRecognition() {
  try {
    recognition.start();
    console.log('Reconnaissance vocale démarrée.');
    recognitionTimeout = setTimeout(() => {
      console.log('Timeout atteint, arrêt de la reconnaissance.');
      recognition.stop();
    }, 10000); // Timeout de 10 secondes
  } catch (e) {
    console.error('Erreur lors du démarrage de la reconnaissance : ', e.message);
  }
}

startRecognition();
JAVASCRIPT

cbc.touch(true) do
  JS.eval(recogniction_code)

end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "__TAURI__",
    "error",
    "eval",
    "getElementById",
    "interimResults",
    "lang",
    "listen",
    "log",
    "maxAlternatives",
    "message",
    "onend",
    "onerror",
    "onresult",
    "onstart",
    "payload",
    "playSnare",
    "results",
    "snare",
    "speak",
    "speechSynthesis",
    "start",
    "stop",
    "text",
    "touch",
    "trigger",
    "wav"
  ],
  "__TAURI__": {
    "aim": "The `__TAURI__` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `__TAURI__`."
  },
  "error": {
    "aim": "The `error` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `error`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "getElementById": {
    "aim": "The `getElementById` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getElementById`."
  },
  "interimResults": {
    "aim": "The `interimResults` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `interimResults`."
  },
  "lang": {
    "aim": "The `lang` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `lang`."
  },
  "listen": {
    "aim": "The `listen` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `listen`."
  },
  "log": {
    "aim": "The `log` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `log`."
  },
  "maxAlternatives": {
    "aim": "The `maxAlternatives` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `maxAlternatives`."
  },
  "message": {
    "aim": "The `message` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `message`."
  },
  "onend": {
    "aim": "The `onend` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `onend`."
  },
  "onerror": {
    "aim": "The `onerror` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `onerror`."
  },
  "onresult": {
    "aim": "The `onresult` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `onresult`."
  },
  "onstart": {
    "aim": "The `onstart` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `onstart`."
  },
  "payload": {
    "aim": "The `payload` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `payload`."
  },
  "playSnare": {
    "aim": "The `playSnare` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `playSnare`."
  },
  "results": {
    "aim": "The `results` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `results`."
  },
  "snare": {
    "aim": "The `snare` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `snare`."
  },
  "speak": {
    "aim": "The `speak` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `speak`."
  },
  "speechSynthesis": {
    "aim": "The `speechSynthesis` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `speechSynthesis`."
  },
  "start": {
    "aim": "The `start` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `start`."
  },
  "stop": {
    "aim": "The `stop` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `stop`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "trigger": {
    "aim": "The `trigger` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `trigger`."
  },
  "wav": {
    "aim": "The `wav` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `wav`."
  }
}
end
