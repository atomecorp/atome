const atomeJS = Object.assign(communication, File);

// generic callback method


async function callback(callback_method, cmd) {
    let ruby_callback_method = 'A.callback(:' + callback_method + ')'
    let instance_variable_to_set = '@' + callback_method + '_code'
    let cmd_result;
    try {
        let response;
        response = await 'ok'
        cmd_result = response;
    } catch (error) {
        cmd_result = error;
    }
    atomeJsToRuby("Atome.instance_variable_set('" + instance_variable_to_set + "','" + cmd_result + "')")
    atomeJsToRuby(ruby_callback_method)
}

//read file


async function readFile(atome_id, filePath) {
    let fileContent;
    try {
        fileContent = await window.__TAURI__.invoke('read_file', {filePath: filePath});
    } catch (error) {
        fileContent = error;
    }
    // alert(fileContent);
    atomeJsToRuby("grab(:" + atome_id + ").callback({ read: '" + fileContent + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").call(:read)");
}


// list folder

// almost works
async function browseFile(atome_id, directoryPath) {
    let directoryContent;
    try {
        directoryContent = await window.__TAURI__.invoke('list_directory_content', {directoryPath: directoryPath});
    } catch (error) {
        directoryContent = error;
    }
    atomeJsToRuby("grab(:" + atome_id + ").callback({ browse: '" + directoryContent + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").call(:browse)");
}


// change dir

async function changeCurrentDirectory(atome_id, newPath) {
    let result;
    try {
        // Utilisez Tauri pour changer le répertoire de travail courant
        result = await window.__TAURI__.invoke('change_dir', {path: newPath});
    } catch (error) {
        result = error;
    }
    // alert('result is : ' + result);
}


// Terminal

async function terminal(atome_id, cmd) {
    let cmd_result;
    try {
        const command = cmd;
        let response;
        response = await window.__TAURI__.invoke('execute_command', {command});
        cmd_result = response;
    } catch (error) {
        cmd_result = error;
    }
    cmd_result = cmd_result.replace(/\r?\n/g, "");

    atomeJsToRuby("grab(:" + atome_id + ").callback({ terminal: '" + cmd_result + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").call(:terminal)");

}


function distant_terminal(id, cmd) {
    let myd_data_test = 'Terminal particle will soon be implemented when using  a non native mode\nYou can switch to OSX to test';
    let call_back_to_send = `grab(:${id}).callback({terminal: "${myd_data_test}"})`
    let call = `grab(:${id}).call(:terminal)`
    atomeJsToRuby(call_back_to_send)
    atomeJsToRuby(call)
}


// we check if we are in tauri context
// if (typeof window.__TAURI__ !== 'undefined') {
//     callExecuteCommand('pwd');
//
// } else {
// }


// 'ls -l'


//read/write
//
// // Créer un fichier
// async function createAndWriteFile(filePath, contentToWrite) {
//     try {
//         await window.__TAURI__.invoke('write_file', {
//             file_path: filePath,
//             content: contentToWrite
//         });
//         console.log('File written successfully.');
//     } catch (error) {
//         console.error('Error writing to file:', error);
//     }
// }
//
// // Lire un fichier
// async function readAndDisplayFile(filePath) {
//     try {
//         const fileContent = await window.__TAURI__.invoke('read_file', {
//             file_path: filePath
//         });
//         console.log('File content:', fileContent);
//     } catch (error) {
//         console.error('Error reading file:', error);
//     }
// }
//
// // Utiliser les fonctions pour créer et lire le fichier
// const filePath = 'example.txt'; // Remplacez ceci par le chemin du fichier souhaité
// const contentToWrite = 'This is some content to write to the file.';
//
// // Créer un fichier avec le contenu
// createAndWriteFile(filePath, contentToWrite);
//
// // Lire le fichier
// readAndDisplayFile(filePath);

function createSvgElement(tagName, attributes) {
    var elem = document.createElementNS('http://www.w3.org/2000/svg', tagName);
    for (var attr in attributes) {
        if (attributes.hasOwnProperty(attr)) {
            elem.setAttribute(attr, attributes[attr]);
        }
    }
    return elem;
}

//
// function sanitizeString(str) {
//     return str.replace(/'/g, "\\'");
// }
// function fileread(){
//     var inputElement = document.createElement("input");
//     inputElement.type = "file";
//
//     inputElement.addEventListener("change", function(event) {
//         var file = event.target.files[0];
//         var reader = new FileReader();
//
//         reader.onload = function(event) {
//             var content = event.target.result;
//             var sanitizedContent = sanitizeString(content);
//             atomeJsToRuby("input_callback('"+sanitizedContent+"')");
//         };
//
//         reader.readAsText(file);
//     });
//
// // Ajout de l'élément input à la div
//     var viewDiv = document.querySelector("#support");
//     viewDiv.appendChild(inputElement);
// }


function fileForOpal(parent, bloc) {
    let input = document.createElement('input');
    input.type = 'file';
    input.style.position = "absolute";
    input.style.display = "none";
    input.style.width = "0px";
    input.style.height = "0px";
    input.addEventListener('change', function (event) {
        let file = event.target.files[0];
        let reader = new FileReader();

        reader.onloadstart = function () {
            console.log("Load start");
        };

        reader.onprogress = function (e) {
            console.log("Loading: " + (e.loaded / e.total * 100) + '%');
        };

        reader.onload = function (e) {
            var content = e.target.result;
            Opal.Atome.$file_handler(parent, content, bloc)
        };

        reader.onloadend = function () {
            console.log("Load end");
        };

        reader.onerror = function () {
            console.error("Error reading file");
        };

        reader.readAsText(file);
    });
    let div_element = document.getElementById(parent);
    div_element.appendChild(input);
    div_element.addEventListener('mousedown', function (event) {
        input.click()
    })

}


function loadFeature() {
    if (NativeMode) {
        // fetch('js/molecules/web.js')
        //     .then(response => {
        //         if (response.ok) {
        //             return response.text();
        //         }
        //         throw new Error('Le chargement du fichier a échoué');
        //     })
        //     .then(data => {
        //         // console.log(data);
        //         eval(data);
        //         // you can use file content as you want
        //     })
        //     .catch(error => {
        //         console.error('Erreur lors du chargement du fichier:', error);
        //     });
        fetch('js/molecules/web.js')
            .then(response => {
                if (response.ok) {
                    return response.text();
                }
                throw new Error('load fail');
            })
            .then(data => {
                var script = document.createElement('script');
                script.type = 'text/javascript';
                script.text = data;
                document.head.appendChild(script);
            })
            .catch(error => {
                console.error('Erreur lors du chargement du fichier:', error);
            });

    } else {
        var script = document.createElement('script');
        script.src = 'js/molecules/web.js?' + new Date().getTime();
        // script.onload = function () {
        //     // Code to use loaded features
        // };

        document.head.appendChild(script);
    }
}

///test methode
// function my_opal_js_fct(val){
//     Opal.eval("my_ruby_meth('opal call ruby with eval: "+val+"')");
//     Opal.Object.$my_ruby_meth('opal call ruby with method name: '+val);
// }
// /////////////////////////////////////////
// let atomeStore={};
//
// function writeatomestore(value) {
//     atomeStore = value; // Stocke la valeur passée dans atomeStore.
// }
//
// function readatomestore() {
//     return atomeStore; // Retourne la valeur stockée dans atomeStore.
// }
// ////////////////////////////////////////

let atomeStore = {}
function writeatomestore(primaryKey, secondaryKey, value) {
    if (!atomeStore[primaryKey]) {
        atomeStore[primaryKey] = {};
    }
    atomeStore[primaryKey][secondaryKey] = value;
}

function readatomestore(primaryKey, secondaryKey) {
    if (atomeStore.hasOwnProperty(primaryKey) && atomeStore[primaryKey].hasOwnProperty(secondaryKey)) {
        return atomeStore[primaryKey][secondaryKey];
    } else {
        console.error("MediaRecorder not found");
        return null;
    }
}


// Audio recorder

function recordAudio(duration, atome_id) {
    writeatomestore(atome_id, 'record', 'playing')

    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        console.log("Your browser doesn't support audio recording");
        return;
    }

    navigator.mediaDevices.getUserMedia({ audio: true })
        .then(function (stream) {
            const audioOptions = [
                'audio/webm',
                'audio/webm;codecs=opus',
                'audio/ogg',
                'audio/wav'
            ];

            let mimeType = audioOptions.find(option => MediaRecorder.isTypeSupported(option));
            const mediaRecorder = new MediaRecorder(stream, mimeType ? { mimeType: mimeType } : {});

            let audioChunks = [];

            // Start recording with a timeslice to trigger data available events periodically
            mediaRecorder.start(10); // Timeslice of 1000 ms

            mediaRecorder.ondataavailable = function (event) {
                // console.log("Data available from recording: ", event);
                if (readatomestore(atome_id, 'record') == 'stop'){
                    mediaRecorder.stop();
                }
                audioChunks.push(event.data);
                // if (audio_recorder_callback) {
                //     audio_recorder_callback(event.data);
                // }
            };

            setTimeout(() => {
                mediaRecorder.stop();
            }, duration);

            mediaRecorder.onstop = function () {
                const audioBlob = new Blob(audioChunks, { type: mimeType || 'audio/mp4' });
                const audioUrl = URL.createObjectURL(audioBlob);

                // Functions to handle the recording post processing
                record_content(audioUrl);
                playRecording(audioBlob);
                saveRecording(audioUrl);

                // Ensure all tracks are stopped once recording is finished
                stream.getTracks().forEach(track => track.stop());
            };
        })
        .catch(function (err) {
            console.error("Error when accessing microphone: " + err);
        });
}


// # video recorder
// function create_preview(preview_id) {
//     if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
//         console.log("Your browser doesn't support media recording");
//         return;
//     }
//
//     navigator.mediaDevices.getUserMedia({ audio: true, video: true })  // Activation de la vidéo
//         .then(function (stream) {
//             window.mediaStream = stream; // Sauvegarde du stream pour utilisation ultérieure
//             console.log("Media stream ready. You can start recording.");
//
//             // Création ou récupération de la div pour le preview
//             let previewContainer = document.getElementById(preview_id);
//             if (!previewContainer) {
//                 previewContainer = document.createElement('div');
//                 previewContainer.id = preview_id;
//
//                 const viewDiv = document.getElementById('view');
//                 viewDiv.appendChild(previewContainer);
//                 // document.body.appendChild(previewContainer); // Ajout de la div au body du document
//             }
//
//             // Création de l'élément vidéo pour le preview
//             const videoElement = document.createElement('video');
//             videoElement.controls = true;
//             videoElement.autoplay = true;
//             videoElement.muted = true; // Mute pour éviter l'écho pendant la prévisualisation
//             videoElement.srcObject = stream;
//
//             // Ajout de l'élément vidéo à la div
//             previewContainer.appendChild(videoElement);
//             previewContainer.style.backgroundColor = '#c8e6c9'; // Couleur de fond pour indiquer l'activité
//         })
//         .catch(function (err) {
//             console.error("Error when accessing media devices: " + err);
//         });
// }
function create_preview(preview_id, enableVideo, enableAudio) {
    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        console.log("Your browser doesn't support media recording");
        return;
    }

    navigator.mediaDevices.getUserMedia({ audio: enableAudio, video: enableVideo })
        .then(function (stream) {
            window.mediaStream = stream; // Sauvegarde du stream pour utilisation ultérieure
            console.log("Media stream ready. You can start recording.");

            // Création ou récupération de la div pour le preview
            let previewContainer = document.getElementById(preview_id);
            if (!previewContainer) {
                previewContainer = document.createElement('div');
                previewContainer.id = preview_id;

                const viewDiv = document.getElementById('view');
                if (viewDiv) {
                    viewDiv.appendChild(previewContainer);
                } else {
                    document.body.appendChild(previewContainer); // Fallback si 'view' n'existe pas
                }
            }

            if (enableVideo == 'true') {
                // Création de l'élément vidéo pour le preview si vidéo demandée
                const videoElement = document.createElement('video');
                videoElement.controls = true;
                videoElement.autoplay = true;
                videoElement.muted = true; // Mute pour éviter l'écho pendant la prévisualisation
                videoElement.srcObject = stream;
                videoElement.muted = false; // Ajustement pour le contrôle du son
                videoElement.volume = 1.0; // Réglage du volume au maximum
                previewContainer.appendChild(videoElement); // Ajout de l'élément vidéo à la div
            } else {
                console.log("Video preview is disabled.");
            }

            if (enableAudio == 'true') {
                // Création d'un élément audio pour le preview si audio demandé
                const audioElement = document.createElement('audio');
                audioElement.controls = true;
                audioElement.autoplay = true;
                audioElement.srcObject = stream;
                previewContainer.appendChild(audioElement); // Ajout de l'élément audio à la div

            }

            previewContainer.style.backgroundColor = '#c8e6c9'; // Couleur de fond pour indiquer l'activité
        })
        .catch(function (err) {
            console.error("Error when accessing media devices: " + err);
        });
}



function recordVideo(duration, atome_id) {
    writeatomestore(atome_id, 'record', 'playing')

    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        console.log("Your browser doesn't support video recording");
        return;
    }

    navigator.mediaDevices.getUserMedia({audio: true, video: true})
        .then(function (stream) {
            const mediaOptions = [
                'video/webm; codecs=vp9,opus',
                'video/webm; codecs=vp8,opus',
                'video/webm'
            ];

            let mimeType = mediaOptions.find(option => MediaRecorder.isTypeSupported(option));
            const mediaRecorder = new MediaRecorder(stream, mimeType ? {mimeType: mimeType} : {});

            let mediaChunks = [];
            // let videoElement = document.querySelector('video#livePreview');

            // Create a video element if it does not exist
            // if (!videoElement) {
            //     videoElement = document.createElement('video');
            //     videoElement.id = 'livePreview';
            //     videoElement.controls = true;
            //     videoElement.autoplay = true;
            //
            //     const viewDiv = document.getElementById('view');
            //     viewDiv.appendChild(videoElement);
            // }

            // Set the source of the video element to the live media stream
            // videoElement.srcObject = stream;

            // Start recording with a timeslice to trigger data available events periodically
            mediaRecorder.start(10);  // Set timeslice to 1000 milliseconds
            // atomeJsToRuby("grab(:" + atome_id + ").js_callback('"+atome_id+"','record','"+mediaRecorder+"', 'video')");
          //   updateData(atome_id, 'record', mediaRecorder)
          //
          // callback_container('atome', 'record');

            // updateData('atome', 'recorder', mediaRecorder);

            // stop_recording(atome_id, 'recorder')

             // recorder = getMediaRecorder(atome_id, 'recorder');
            // alert (recorder)

            mediaRecorder.ondataavailable = function (event) {
              if (readatomestore(atome_id, 'record') == 'stop'){
                  mediaRecorder.stop();
              }
                // console.log(atomeStore)
              // writeatomestore(atome_id, 'record', 'stop')
                // console.log("Chunk of video data available: ", event);
                // atomeJsToRuby("grab(:" + atome_id + ").js_callback('"+atome_id+"','"+event+"','record', 'video')");
                // atomeJsToRuby("grab(:" + atome_id + ").js_callback('"+atome_id+"','"+event+"','"+mediaChunks+"', 'video')");
                // mediaChunks.push(event.data);
                mediaChunks.push(event.data);
            };

            // Stop recording after the specified duration
            setTimeout(() => {
                mediaRecorder.stop();
            }, duration);

            mediaRecorder.onstop = function () {
                const mediaBlob = new Blob(mediaChunks, {type: mimeType || 'video/mp4'});
                const mediaUrl = URL.createObjectURL(mediaBlob);

                // Functions to handle the recording post-processing
                record_content(mediaUrl);
                playRecording(mediaBlob);
                saveRecording(mediaUrl);

                // Stop all media tracks and clear the video element source
                stream.getTracks().forEach(track => track.stop());
                // videoElement.srcObject = null;
            };
        })
        .catch(function (err) {
            console.error("Error when accessing peripherals: " + err);
        });
}

// function recordVideo(duration, atome_id) {
//     if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
//         console.log("Your browser doesn't support video recording");
//         return;
//     }
//
//     navigator.mediaDevices.getUserMedia({audio: true, video: true})
//         .then(function (stream) {
//             let mimeType = [
//                 'video/webm; codecs=vp9,opus',
//                 'video/webm; codecs=vp8,opus',
//                 'video/webm'
//             ].find(option => MediaRecorder.isTypeSupported(option));
//
//             const mediaRecorder = new MediaRecorder(stream, mimeType ? {mimeType: mimeType} : {});
//             let mediaChunks = [];
//             let videoElement = document.querySelector('video#livePreview');
//             if (!videoElement) {
//                 videoElement = document.createElement('video');
//                 videoElement.id = 'livePreview';
//                 videoElement.controls = true;
//                 videoElement.autoplay = true;
//
//                 const viewDiv = document.getElementById('view') || document.body;
//                 viewDiv.appendChild(videoElement);
//             }
//
//             videoElement.srcObject = stream;
//             mediaRecorder.start(10);
//
//             mediaRecorder.ondataavailable = function (event) {
//                 mediaChunks.push(event.data);
//             };
//
//             setTimeout(() => {
//                 mediaRecorder.stop();
//             }, duration);
//
//             mediaRecorder.onstop = function () {
//                 const mediaBlob = new Blob(mediaChunks, {type: mimeType || 'video/mp4'});
//                 const mediaUrl = URL.createObjectURL(mediaBlob);
//
//                 record_content(mediaUrl);
//                 playRecording(mediaBlob);
//                 saveRecording(mediaUrl);
//
//                 stream.getTracks().forEach(track => track.stop());
//                 // videoElement.srcObject = null;
//             };
//
//
//
//         })
//         .catch(function (err) {
//             console.error("Error when accessing peripherals: " + err);
//         });
// }



let mediaUrlGlobal = "";

function saveRecording(url) {
    mediaUrlGlobal = url;
    console.log("URL recorded: " + url);
    const downloadLink = document.createElement('a');
    downloadLink.href = url;
    downloadLink.download = "filename.mp4";
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
}

function playRecording(blob) {
    const mediaElement = document.createElement('video');
    mediaElement.src = URL.createObjectURL(blob);
    mediaElement.controls = true; // add control to media element
    const viewDiv = document.getElementById('view');
    viewDiv.appendChild(mediaElement);

}

function record_content(blob) {
    console.log("recorded blob content  :", blob);
}

// recordVideo(5000);

