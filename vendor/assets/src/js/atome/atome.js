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
    atomeJsToRuby("grab(:" + atome_id + ").store_ruby_callback({ read: '" + fileContent + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").read_ruby_callback(:read)");
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
    atomeJsToRuby("grab(:" + atome_id + ").store_ruby_callback({ browse: '" + directoryContent + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").read_ruby_callback(:browse)");
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

    atomeJsToRuby("grab(:" + atome_id + ").store_ruby_callback({ terminal: '" + cmd_result + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").read_ruby_callback(:terminal)");

}


// function distant_terminal(id, cmd) {
//
//     let myd_data_test = 'Terminal particle will soon be implemented when using  a non native mode\nYou can switch to OSX to test';
//     let call_back_to_send = `grab(:${id}).store_ruby_callback({terminal: "${myd_data_test}"})`
//     let call = `grab(:${id}).read_ruby_callback(:terminal)`
//     atomeJsToRuby(call_back_to_send)
//     atomeJsToRuby(call)
//
//     // let call = `grab(:${id}).read_ruby_callback(:terminal)`
//     // atomeJsToRuby(call)
// }


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


// temp storage for active recording media
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


// preview
function create_preview(preview_id, enableVideo, enableAudio) {
    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        console.log("Your browser doesn't support media recording");
        return;
    }

    navigator.mediaDevices.getUserMedia({ audio: enableAudio, video: enableVideo })
        .then(function (stream) {
            window.mediaStream = stream;
            console.log("Media stream ready. You can start recording.");

            let previewContainer = document.getElementById(preview_id);
            if (!previewContainer) {
                previewContainer = document.createElement('div');
                previewContainer.id = preview_id;

                const viewDiv = document.getElementById('view');
                if (viewDiv) {
                    viewDiv.appendChild(previewContainer);
                } else {
                    document.body.appendChild(previewContainer); // Fallback
                }
            }

            if (enableVideo == 'true') {
                const videoElement = document.createElement('video');
                videoElement.controls = true;
                videoElement.autoplay = true;
                videoElement.muted = true;
                videoElement.srcObject = stream;
                videoElement.muted = false;
                videoElement.volume = 1.0;
                previewContainer.appendChild(videoElement);
            } else {
                console.log("Video preview is disabled.");
            }

            if (enableAudio == 'true') {
                const audioElement = document.createElement('audio');
                audioElement.controls = true;
                audioElement.autoplay = true;
                audioElement.srcObject = stream;
                previewContainer.appendChild(audioElement);

            }

        })
        .catch(function (err) {
            console.error("Error when accessing media devices: " + err);
        });
}
function stopPreview(preview_id) {
    const previewContainer = document.getElementById(preview_id);
    if (previewContainer) {
        // Arrêter toutes les pistes du flux
        if (window.mediaStream) {
            window.mediaStream.getTracks().forEach(track => {
                track.stop();
            });
        }

        // Supprimer la `div` de prévisualisation
        previewContainer.remove();
    } else {
        console.log("Preview container not found.");
    }
}
// Audio recorder

function recordAudio(duration, atome_id,filename) {
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

            // Start recording with a time slice to trigger data available events periodically
            mediaRecorder.start(10); // Timeslice of 1000 ms

            mediaRecorder.ondataavailable = function (event) {
                if (readatomestore(atome_id, 'record') == 'stop'){
                    mediaRecorder.stop();
                }
                atomeJsToRuby("grab(:" + atome_id + ").js_callback('"+atome_id+"','record', '"+event.data+"', 'audio')");
                audioChunks.push(event.data);

            };

            setTimeout(() => {
                mediaRecorder.stop();
            }, duration);

            mediaRecorder.onstop = function () {
                const audioBlob = new Blob(audioChunks, { type: mimeType || 'audio/mp4' });
                const audioUrl = URL.createObjectURL(audioBlob);

                // Functions to handle the recording post processing
                if (atome_id === 'atome'){
                    atome_id ='view'
                }
                record_content(audioUrl);
                playRecording(audioBlob,filename,atome_id);
                saveRecording(audioUrl,filename);
                atomeJsToRuby("grab(:" + atome_id + ").js_callback('"+atome_id+"','record','"+audioBlob+"', 'audio')");

                // Ensure all tracks are stopped once recording is finished
                stream.getTracks().forEach(track => track.stop());
            };
        })
        .catch(function (err) {
            console.error("Error when accessing microphone: " + err);
        });
}


// # video recorder

function recordVideo(duration, atome_id, filename) {
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

            mediaRecorder.start(10);  // Set timeslice to 1000 milliseconds


            mediaRecorder.ondataavailable = function (event) {
              if (readatomestore(atome_id, 'record') == 'stop'){
                  mediaRecorder.stop();
              }
                atomeJsToRuby("grab(:" + atome_id + ").js_callback('"+atome_id+"','record', '"+event.data+"', 'video')");
                mediaChunks.push(event.data);
            };

            // Stop recording after the specified duration
            setTimeout(() => {
                mediaRecorder.stop();
            }, duration);

            mediaRecorder.onstop = function () {
                const mediaBlob = new Blob(mediaChunks, {type: mimeType || 'video/mp4'});
                const mediaUrl = URL.createObjectURL(mediaBlob);
                if (atome_id === 'atome'){
                    atome_id ='view'
                }
                // Functions to handle the recording post-processing
                record_content(mediaUrl);
                playRecording(mediaBlob,filename,atome_id);
                saveRecording(mediaUrl,filename);
                atomeJsToRuby("grab(:" + atome_id + ").js_callback('"+atome_id+"','record', '"+mediaBlob+"', 'video')");
                // Stop all media tracks and clear the video element source
                stream.getTracks().forEach(track => track.stop());
                // videoElement.srcObject = null;
            };
        })
        .catch(function (err) {
            console.error("Error when accessing peripherals: " + err);
        });
}


let mediaUrlGlobal = "";

function saveRecording(url,filename) {
    mediaUrlGlobal = url;
    console.log("URL recorded: " + url);
    const downloadLink = document.createElement('a');
    downloadLink.href = url;
    downloadLink.download = filename+".mp4";
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
}

function playRecording(blob,filename, parent) {

    const mediaElement = document.createElement('video');
    mediaElement.src = URL.createObjectURL(blob);
    mediaElement.controls = true; // add control to media element
    mediaElement.id = filename;
    const viewDiv = document.getElementById(parent);
    viewDiv.appendChild(mediaElement);

}

function record_content(blob) {
    console.log("recorded blob content  :", blob);
}


function isDescendant(parentId, childId) {
    var parent = document.getElementById(parentId);
    var child = document.getElementById(childId);

    let node = child;
    while (node !== null) {
        if (node === parent) {
            return true;
        }
        node = node.parentNode;
    }
    return    false;

}
// function pianorollCallback(ev) {
//     // console.log(methodToCallBack+'note playing : ');
//     console.log(ev);
//     console.log('------');
//     // consol
//     // const currentTime = actx.currentTime;
//     // const startTime = currentTime + (ev.t - performance.now() / 1000);
//     // const endTime = currentTime + (ev.g - performance.now() / 1000);
//     // osc.detune.setValueAtTime((ev.n - 69) * 100, startTime);
//     // gain.gain.setTargetAtTime(0.5, startTime, 0.005);
//     // gain.gain.setTargetAtTime(0, endTime, 0.1);
// }
// alert(isDescendant('intuition', 'the_test_box'));
// alert(isDescendant('view', 'the_test_box'));


// ruby JS interoperability examples
function js_test(val){
    console.log(val)
}

class my_test_class {
    myTestFunction(val) {
        console.log("JavaScript fonctionne : " + val);
    }
}

