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
    rubyVMCallback("Atome.instance_variable_set('" + instance_variable_to_set + "','" + cmd_result + "')")
    rubyVMCallback(ruby_callback_method)
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
    rubyVMCallback("grab(:" + atome_id + ").callback({ read: '" + fileContent + "' })");
    rubyVMCallback("grab(:" + atome_id + ").call(:read)");
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
    rubyVMCallback("grab(:" + atome_id + ").callback({ browse: '" + directoryContent + "' })");
    rubyVMCallback("grab(:" + atome_id + ").call(:browse)");
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
    alert('result is : ' + result);
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

    rubyVMCallback("grab(:" + atome_id + ").callback({ terminal: '" + cmd_result + "' })");
    rubyVMCallback("grab(:" + atome_id + ").call(:terminal)");

}


function distant_terminal(id, cmd) {
    let myd_data_test = 'Terminal particle will soon be implemented when using  a non native mode\nYou can switch to OSX to test';
    let call_back_to_send = `grab(:${id}).callback({terminal: "${myd_data_test}"})`
    let call = `grab(:${id}).call(:terminal)`
    rubyVMCallback(call_back_to_send)
    rubyVMCallback(call)
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
//             rubyVMCallback("input_callback('"+sanitizedContent+"')");
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


// function loadFeature() {
//     var script = document.createElement('script');
//     script.src = 'js/molecules/web.js?' + new Date().getTime();
//     // script.onload = function () {
//     //     // Code to use loaded features
//     // };
//    // puts to solve native (osx) compatiblity use fetch
//
//     document.head.appendChild(script);
// }

// function loadFeature() {
//     fetch('js/molecules/web.js')
//         .then(response => {
//             if (response.ok) {
//                 return response.text();
//             }
//             throw new Error('Le chargement du fichier a échoué');
//         })
//         .then(data => {
//             console.log(data); // Log le contenu du fichier web.js
//             // Vous pouvez ici utiliser le contenu du fichier comme nécessaire
//         })
//         .catch(error => {
//             console.error('Erreur lors du chargement du fichier:', error);
//         });
// }


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


// Fonction pour demander l'accès au microphone et démarrer l'enregistrement
// function startRecording() {
//     alert('rec')
//     // // Vérifier si le navigateur supporte les fonctionnalités requises
//     // if (!navigator.mediaDevices || !window.MediaRecorder) {
//     //     alert("Votre navigateur ne supporte pas l'enregistrement audio.");
//     //     return;
//     // }
//     //
//     // // Demander l'accès au microphone
//     // navigator.mediaDevices.getUserMedia({ audio: true })
//     //     .then(stream => {
//     //         const mediaRecorder = new MediaRecorder(stream);
//     //         let audioChunks = [];
//     //
//     //         // Collecter les données d'audio
//     //         mediaRecorder.addEventListener("dataavailable", event => {
//     //             audioChunks.push(event.data);
//     //         });
//     //
//     //         // Lorsque l'enregistrement est arrêté, traiter les données audio
//     //         mediaRecorder.addEventListener("stop", () => {
//     //             const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
//     //             const audioUrl = URL.createObjectURL(audioBlob);
//     //             const downloadLink = document.createElement('a');
//     //             downloadLink.href = audioUrl;
//     //             downloadLink.download = 'recorded_audio.wav';
//     //             downloadLink.textContent = 'Télécharger l\'audio';
//     //             downloadLink.click();
//     //
//     //             // Nettoyer
//     //             audioChunks = [];
//     //             stream.getTracks().forEach(track => track.stop()); // Arrêter le flux
//     //         });
//     //
//     //         // Démarrer l'enregistrement
//     //         mediaRecorder.start();
//     //
//     //         // Arrêter l'enregistrement après 5 secondes
//     //         setTimeout(() => {
//     //             mediaRecorder.stop();
//     //         }, 5000); // Changez cette durée selon le besoin
//     //     })
//     //     .catch(error => {
//     //         console.error("Erreur lors de l'accès au microphone: ", error);
//     //         alert("Impossible d'accéder au microphone. Veuillez réessayer.");
//     //     });
// }

// Appel de la fonction

// Audio recorder

function recordAudio(duration) {
    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        console.log("you browser doesn't support audio recording");
        return;
    }

    navigator.mediaDevices.getUserMedia({ audio: true })
        .then(function(stream) {
            const audioOptions = [
                'audio/webm',
                'audio/webm;codecs=opus',
                'audio/ogg',
                'audio/wav'
            ];

            let mimeType = audioOptions.find(option => MediaRecorder.isTypeSupported(option));
            const mediaRecorder = new MediaRecorder(stream, mimeType ? { mimeType: mimeType } : {});

            let audioChunks = [];

            mediaRecorder.start();

            mediaRecorder.ondataavailable = function(event) {
                audioChunks.push(event.data);
            };

            setTimeout(() => {
                mediaRecorder.stop();
            }, duration);

            mediaRecorder.onstop = function() {
                const audioBlob = new Blob(audioChunks, { type: mimeType || 'audio/mp4' });
                const audioUrl = URL.createObjectURL(audioBlob);

                record_content(audioUrl);
                playRecording(audioBlob);
                saveRecording(audioUrl);

                stream.getTracks().forEach(track => track.stop());
            };
        })
        .catch(function(err) {
            console.error("error when accessing microphone: " + err);
        });
}

// let audioUrlGlobal = "";
//
// function saveRecording(url) {
//     audioUrlGlobal = url;
//     console.log("URL enregistrée: " + url);
//     const downloadLink = document.createElement('a');
//     downloadLink.href = url;
//     downloadLink.download = "enregistrement_audio.mp4";
//     document.body.appendChild(downloadLink);
//     downloadLink.click();
//     document.body.removeChild(downloadLink);
// }
//
// function playRecording(blob) {
//     console.log("Tentative de jouer l'enregistrement directement du blob");
//     const audio = new Audio(URL.createObjectURL(blob));
//     audio.play().then(() => {
//         console.log("Lecture commencée");
//     }).catch(err => {
//         console.error("Erreur lors de la lecture: ", err);
//     });
// }
//
// function record_content(blob) {
//     console.log("Contenu de l'enregistrement audio (Blob) :", blob);
// }

// recordAudio(5000);



// # video recorder
function recordVideo(duration) {
    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        console.log("you browser doesn't support video recording");
        return;
    }

    navigator.mediaDevices.getUserMedia({ audio: true, video: true })
        .then(function(stream) {
            const mediaOptions = [
                'video/webm; codecs=vp9,opus',
                'video/webm; codecs=vp8,opus',
                'video/webm'
            ];

            let mimeType = mediaOptions.find(option => MediaRecorder.isTypeSupported(option));
            const mediaRecorder = new MediaRecorder(stream, mimeType ? { mimeType: mimeType } : {});

            let mediaChunks = [];
            let videoElement = document.querySelector('video#livePreview');

            if (!videoElement) {
                videoElement = document.createElement('video');
                videoElement.id = 'livePreview';
                videoElement.controls = true;
                videoElement.autoplay = true;

                const viewDiv = document.getElementById('view');
                viewDiv.appendChild(videoElement);
            }

            videoElement.srcObject = stream;

            mediaRecorder.start();

            mediaRecorder.ondataavailable = function(event) {
                mediaChunks.push(event.data);
            };

            setTimeout(() => {
                mediaRecorder.stop();
            }, duration);

            mediaRecorder.onstop = function() {
                const mediaBlob = new Blob(mediaChunks, { type: mimeType || 'video/mp4' });
                const mediaUrl = URL.createObjectURL(mediaBlob);

                record_content(mediaUrl);
                playRecording(mediaBlob);
                saveRecording(mediaUrl);

                stream.getTracks().forEach(track => track.stop());
                videoElement.srcObject = null;
            };
        })
        .catch(function(err) {
            console.error("error when accessing peripherals: " + err);
        });
}


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
    // mediaElement.play().then(() => {
    // }).catch(err => {
    //     console.error("Error when reading: ", err);
    // });
}

function record_content(blob) {
    console.log("recorded blob content  :", blob);
}

// recordVideo(5000);

