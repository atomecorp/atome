function escapeApostrophes(input) {
    return input.replace(/'/g, "\\'");
}

let stop_recognition_listening = null;


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
    stop_recognition_listening = false;
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
        const stream = await navigator.mediaDevices.getUserMedia({audio: true});
        audioContext = new (window.AudioContext || window.webkitAudioContext)();
        mediaStreamSource = audioContext.createMediaStreamSource(stream);
        analyser = audioContext.createAnalyser();
        mediaStreamSource.connect(analyser);

        recognition.start();
        isRecording = true;
        monitorSilence();

        let intervalId = setInterval(() => {
            if (stop_recognition_listening === true) {
                stopListening();
                clearInterval(intervalId);
                console.log("Stopped listening via interval check");
            }
        }, 100);
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
        let logInterval = 1000;
        let lastLogTime = Date.now();

        function checkVolume() {
            analyser.getByteFrequencyData(dataArray);
            const volume = dataArray.reduce((sum, value) => sum + value, 0);

            if (Date.now() - lastLogTime >= logInterval) {
                console.log("Recording... Volume level:", volume);
                lastLogTime = Date.now();
            }

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
        stop_recognition_listening = true;
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
                messages: [{role: 'user', content: `Translate in ${lang} : ${text}`}]
            })
        });

        const data = await response.json();
        if (data.choices && data.choices[0].message.content) {
            console.log(`Traduction : "${data.choices[0].message.content.trim()}"`);
            const sanitizedText = escapeApostrophes(data.choices[0].message.content.trim());
            atomeJsToRuby(method_to_trig + "('" + sanitizedText + "')");
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
    atomeJsToRuby(method_to_trig + "('" + sanitizedText + "')");
}


function speechToText(silenceDuration, silenceThreshold, enableTranslation, targetLanguage, convert, open_ai_key, rubyTranslationCallback, rubyAudio2textCallback, active) {
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
