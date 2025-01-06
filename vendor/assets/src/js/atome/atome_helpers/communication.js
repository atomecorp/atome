function escapeApostrophes(input) {
    return input.replace(/'/g, "\\'");
}


//////////




function convertTextToSpeech({
                                 silenceDuration = 3000,
                                 silenceThreshold = 5,
                                 enableTranslation = false,
                                 targetLanguage = 'en',
                                 convert = true,
                                 open_ai_key,
                                 rubyTranslationCallback,
                                 rubyAudio2textCallback,
                                active
                             }) {


    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!SpeechRecognition) {
        console.error("Web Speech API is not supported on your browser");
        return;
    }

    let recognition;
    let isRecording = false;
    let silenceTimer;
    let audioContext;
    let analyser;
    let mediaStreamSource;

    recognition = new SpeechRecognition();
    recognition.lang = 'fr-FR';
    recognition.interimResults = false;
    recognition.continuous = true;

    recognition.onresult = (event) => {
        let finalTranscript = '';
        for (let i = 0; i < event.results.length; i++) {
            finalTranscript += event.results[i][0].transcript;
        }
        console.log("Transcription :", finalTranscript);

        if (typeof audio2textCallback === 'function') {
            audio2textCallback(finalTranscript, rubyAudio2textCallback);
        }

        if (enableTranslation && typeof translationCallback === 'function') {
            translationCallback(finalTranscript, targetLanguage, open_ai_key, rubyTranslationCallback);
        }
    };

    recognition.onerror = (event) => {
        console.error("Erreur de transcription :", event.error);
    };

    async function startListening() {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        audioContext = new (window.AudioContext || window.webkitAudioContext)();
        mediaStreamSource = audioContext.createMediaStreamSource(stream);
        analyser = audioContext.createAnalyser();
        mediaStreamSource.connect(analyser);

        recognition.start();
        isRecording = true;
        monitorSilence();
    }

    function stopListening() {
        if (isRecording) {
            isRecording = false;
            recognition.stop();
            if (audioContext) {
                audioContext.close();
                audioContext = null;
            }
        }
    }

    function monitorSilence() {
        const dataArray = new Uint8Array(analyser.fftSize);

        function checkVolume() {
            analyser.getByteFrequencyData(dataArray);
            const volume = dataArray.reduce((sum, value) => sum + value, 0);

            if (volume < silenceThreshold) {
                if (!silenceTimer) {
                    silenceTimer = setTimeout(() => {
                        stopListening();
                    }, silenceDuration);
                }
            } else {
                resetSilenceTimer();
            }

            if (isRecording) {
                requestAnimationFrame(checkVolume);
            }
        }

        checkVolume();
    }

    function resetSilenceTimer() {
        clearTimeout(silenceTimer);
        silenceTimer = null;
    }

    // Listening control based on convert. `convert`
    if (active) {
        startListening();
    } else {
        stopListening();
    }
}

// Translation function
async function translationCallback(text, lang, open_ai_key, method_to_trig) {

    try {
        const response = await fetch('https://api.openai.com/v1/chat/completions', {
            method: 'POST',
            headers: {
                'Authorization': open_ai_key,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                model: 'gpt-4',
                messages: [{ role: 'user', content: `Translate in ${lang} : ${text}` }]
            })
        });

        const data = await response.json();
        if (data.choices && data.choices[0].message.content) {
            console.log(`Traduction : "${data.choices[0].message.content.trim()}"`);
            const sanitizedText = escapeApostrophes(data.choices[0].message.content.trim());
            atomeJsToRuby(method_to_trig+"('"+sanitizedText+"')");
        } else {
            throw new Error("Aucune réponse valide.");
        }
    } catch (error) {
        console.error("Erreur de traduction :", error);
    }
}

// Function for transcription
function audio2textCallback(text, method_to_trig) {
    console.log(`Texte depuis le fichier audio: "${text}"`);
    const sanitizedText = escapeApostrophes(text);
    atomeJsToRuby(method_to_trig+"('"+sanitizedText+"')");
}



function speechToText(silenceDuration,silenceThreshold, enableTranslation, targetLanguage, convert, open_ai_key, rubyTranslationCallback, rubyAudio2textCallback, active){
    // alert(silenceDuration+','+silenceThreshold+','+ enableTranslation+','+targetLanguage+','+ convert+','+ open_ai_key+','+ rubyTranslationCallback+','+ rubyAudio2textCallback+','+ active)
    convertTextToSpeech({
        silenceDuration: silenceDuration,
        silenceThreshold: silenceThreshold,
        enableTranslation: enableTranslation,
        targetLanguage: targetLanguage,
        convert: convert,
        open_ai_key: open_ai_key,
        rubyTranslationCallback: rubyTranslationCallback,
        rubyAudio2textCallback: rubyAudio2textCallback,
        active: active
});
}


// translationCallback: translationCallback,
//     audio2textCallback: audio2textCallback


// setTimeout(() => {
//     // atomeJsToRuby('box');
//     text="Peux-tu écrire une lettre à Sarah lui dire bonjour tout va bien et tu m'ouvre le fichier une fois que t'as fini"
//     const sanitizedText = escapeApostrophes(text);
//     atomeJsToRuby('to_text_method'+"('"+sanitizedText+"')");
// }, "1000");




/////////////////////////// connection ws

//
// function connect(address) {
//
//     websocket = new WebSocket(address);
//
//     websocket.onopen = function (event) {
//         atomeJsToRuby("puts 'Connected to WebSocket'")
//
//     };
//
//     websocket.onmessage = function (event) {
//         // atomeJsToRuby("puts 'object ruby callback : " + event.data + "'")
//     };
//
//     websocket.onclose = function (event) {
//         atomeJsToRuby("puts 'WebSocket closed'")
//     };
//
//     websocket.onerror = function (event) {
//         // to prevent error disturbing the console
//         event.preventDefault();
//         console.log('connection lost!')
//     };
//
// }


// function controller_message(msg) {
//     // let json_msgs = JSON.parse(msg);
//     atomeJsToRuby("A.receptor("+msg+")")
// }