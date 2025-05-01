const atomeJS = Object.assign(communication, File);


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


async function readFile(atome_id, filePath, _file_content) {
    let fileContent;
    try {
        fileContent = await window.__TAURI__.core.invoke('read_file', { filePath: filePath });
    } catch (error) {
        fileContent = error;
    }
    atomeJsToRuby("grab(:" + atome_id + ").store_ruby_callback({ read: '" + fileContent + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").read_ruby_callback(:read)");
}


async function writeFile(atome_id, filePath, content) {

    let fileContent;
    try {
        fileContent = await window.__TAURI__.core.invoke('write_file', { filePath: filePath, content: content });
    } catch (error) {
        fileContent = error;
    }

    atomeJsToRuby("grab(:" + atome_id + ").store_ruby_callback({ write: '" + fileContent + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").read_ruby_callback(:write)");
}

// list folder

// almost works
async function browseFile(atome_id, directoryPath) {

    let directoryContent;
    try {
        directoryContent = await window.__TAURI__.core.invoke('list_directory_content', { directoryPath: directoryPath });
    } catch (error) {
        directoryContent = error;
    }
    console.log('browseFile say  : '+directoryContent)

// Affiche le contenu ou l'erreur
    atomeJsToRuby("grab(:" + atome_id + ").store_ruby_callback({ browse: '" + directoryContent + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").read_ruby_callback(:browse)");
}


// change dir

async function changeCurrentDirectory(atome_id, newPath) {
    let result;
    try {
        // Utilise Tauri pour changer le répertoire de travail courant
        result = await window.__TAURI__.core.invoke('change_dir', {path: newPath});
    } catch (error) {
        result = error;
    }
   return result
}




async function terminal(atome_id, cmd) {
    let cmd_result;
    try {
        const command = cmd;
        let response;
        response = await window.__TAURI__.core.invoke('execute_command', { command });
        cmd_result = response;
    } catch (error) {
        cmd_result = error;
    }

    atomeJsToRuby("grab(:" + atome_id + ").store_ruby_callback({ terminal: '" + cmd_result + "' })");
    atomeJsToRuby("grab(:" + atome_id + ").read_ruby_callback(:terminal)");
}

function createSvgElement(tagName, attributes) {
    var elem = document.createElementNS('http://www.w3.org/2000/svg', tagName);
    for (var attr in attributes) {
        if (attributes.hasOwnProperty(attr)) {
            elem.setAttribute(attr, attributes[attr]);
        }
    }
    return elem;
}

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
        let filename = file.name;
        let extension = filename.split('.').pop().toLowerCase();

        reader.onloadstart = function () {
            // console.log("Load start");
        };

        reader.onprogress = function (e) {
            // console.log("Loading: " + (e.loaded / e.total * 100) + '%');
        };

        // Déterminer la méthode de lecture en fonction du type de fichier
        const textExtensions = ['txt', 'lrx', 'lrs', 'prx','json', 'xml', 'html', 'css', 'js', '.rb'];
        const isTextFile = textExtensions.includes(extension);

        reader.onload = function (e) {
            let content;

            if (isTextFile) {
                // Pour les fichiers texte, utiliser le contenu textuel
                content = e.target.result;
            } else {
                // Pour les fichiers binaires, créer une URL d'objet
                content = URL.createObjectURL(file);
            }

            // Passer les informations du fichier au handler Opal
            Opal.Atome.$file_handler(parent, filename, content, bloc);
        };

        reader.onloadend = function () {
            // console.log("Load end");
        };

        reader.onerror = function () {
            console.error("Error reading file");
        };

        // Choisir la méthode de lecture selon le type de fichier
        if (isTextFile) {
            reader.readAsText(file);
        } else {
            // Pour les fichiers binaires (audio, images, etc.)
            reader.readAsArrayBuffer(file);
        }
    });
    let div_element = document.getElementById(parent);
    div_element.appendChild(input);
    div_element.addEventListener('mousedown', function (event) {
        input.click();
    });
}


function loadFeature() {
    if (NativeMode) {
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
//
// ruby JS interoperability examples
function js_test(val){
    console.log(val)
}

class my_test_class {
    myTestFunction(val) {
        console.log("JavaScript fonctionne : " + val);
    }
}


// right click handling


let isRightClickDisabled = true;

document.addEventListener("contextmenu", function (e) {
    if (isRightClickDisabled) {
        e.preventDefault();
    }
});

// Fonction pour activer le clic droit
function enableRightClick() {
    isRightClickDisabled = false;
}

// Fonction pour désactiver le clic droit
function disableRightClick() {
    isRightClickDisabled = true;
}


// Redefined console.log
window.console.log=(function(oldLog){
    return function(message){
        oldLog(message)
        try{
            atomeJsToRuby("A.to_console('"+message+"')")
            window.webkit.messageHandlers.console.postMessage("LOG: "+message)
        }
        catch(e){oldLog()}
    }
})(window.console.log)

window.console.error=(function(oldErr){
    return function(message){
        oldErr(message)
        try{
            atomeJsToRuby("A.to_console('"+message+"')")
            window.webkit.messageHandlers.console.postMessage("ERROR: "+message)
        }
        catch(e){oldErr()}
    }
})(window.console.error)


document.addEventListener("DOMContentLoaded", function() {
    // console.log("DOM fully loaded and parsed");

    window.updateTimecode = function(time) {
        console.log("updateTimecode called with:", time); // Debug
        let timecodeElement = document.getElementById('timecode');
        if (timecodeElement) {
            console.log("Mise à jour du timecode avec la valeur:", time); // Debug
            timecodeElement.textContent = time;
        } else {
            console.error("Element #timecode introuvable !");
        }
    };

    // Pour envoyer des messages à Swift
    window.sendMessageToNative = function(message) {
        console.log("Envoi du message à Swift:", message); // Debug
        window.webkit.messageHandlers.hostHandler.postMessage(message);
    };
});

//////////



// Configuration
const DB_VERSION = 1;
const STORE_NAME = 'files';
let db = null;

// Callback pour les résultats et erreurs
function idb_listener(operation, result) {

    let resultStr;
    if (typeof result === 'object') {
        try {
            // Option 1: Format plus lisible avec indentation
            resultStr = JSON.stringify(result, null, 2);
            // Option 2: Format compact sans indentation
            // resultStr = JSON.stringify(result);

            atomeJsToRuby("A.idb_load_callback('"+operation+"','"+resultStr+"')");

        } catch (e) {
            resultStr = "[Erreur: Impossible de convertir l'objet en JSON]";
        }
    } else {
        resultStr = result;
    }

    /////


    ///test_below
    // console.log(`Operation: ${operation}`, result);
    // Afficher le résultat dans la page
    const output = document.getElementById('view');
    output.innerHTML += `<p>${operation}: ${result.success ? 'Success' : 'Error'} - ${JSON.stringify(result)}</p>`;
}

// Ouvrir la base de données (fonction interne)
function _openDatabase(dbname) {
    return new Promise((resolve, reject) => {
        if (db !== null) {
            resolve(db);
            return;
        }

        const request = indexedDB.open(dbname, DB_VERSION);

        request.onupgradeneeded = function(event) {
            const database = event.target.result;
            if (!database.objectStoreNames.contains(STORE_NAME)) {
                database.createObjectStore(STORE_NAME);
            }
        };

        request.onerror = function(event) {
            const error = new Error(`DB open error: ${event.target.error?.message || "unknown"}`);
            reject(error);
        };

        request.onsuccess = function(event) {
            db = event.target.result;
            resolve(db);
        };
    });
}

// Sauver des données
function idb_save(dbname, filename, content) {
    const dbToUse = db ? db.name : dbname;

    _openDatabase(dbToUse)
        .then(database => {
            try {
                const transaction = database.transaction([STORE_NAME], 'readwrite');
                const store = transaction.objectStore(STORE_NAME);

                // Convertir en string si objet
                const contentString = typeof content === 'string' ? content : JSON.stringify(content);
                const putRequest = store.put(contentString, filename);

                putRequest.onerror = function(event) {
                    const error = new Error(`Save error: ${event.target.error?.message || "unknown"}`);
                    idb_listener('save', { success: false, error: error.message });
                };

                putRequest.onsuccess = function() {
                    const result = { success: true, filename };
                    idb_listener('save', result);
                };
            } catch (error) {
                idb_listener('save', { success: false, error: error.message });
            }
        })
        .catch(error => {
            idb_listener('save', { success: false, error: error.message });
        });
}

// Charger des données
function idb_load(dbname, filename) {
    const dbToUse = db ? db.name : dbname;

    _openDatabase(dbToUse)
        .then(database => {
            try {
                const transaction = database.transaction([STORE_NAME], 'readonly');
                const store = transaction.objectStore(STORE_NAME);
                const getRequest = store.get(filename);

                getRequest.onerror = function(event) {
                    const error = new Error(`Load error: ${event.target.error?.message || "unknown"}`);
                    idb_listener('load', { success: false, error: error.message });
                };

                getRequest.onsuccess = function() {
                    if (getRequest.result) {
                        // Tenter de parser le JSON
                        let parsedData = getRequest.result;
                        try {
                            if (typeof parsedData === 'string' &&
                                (parsedData.startsWith('{') || parsedData.startsWith('['))) {
                                parsedData = JSON.parse(parsedData);
                            }
                        } catch (e) {
                            // Garder en string si l'analyse échoue
                        }

                        const result = { success: true, filename, data: parsedData };
                        idb_listener('load', result);
                    } else {
                        const error = new Error(`File '${filename}' not found`);
                        idb_listener('load', { success: false, error: error.message });
                    }
                };
            } catch (error) {
                idb_listener('load', { success: false, error: error.message });
            }
        })
        .catch(error => {
            idb_listener('load', { success: false, error: error.message });
        });
}

// Lister toutes les données
function idb_list(dbname) {
    const dbToUse = db ? db.name : dbname;

    _openDatabase(dbToUse)
        .then(database => {
            try {
                const transaction = database.transaction([STORE_NAME], 'readonly');
                const store = transaction.objectStore(STORE_NAME);
                const allRequest = store.getAll();
                const keysRequest = store.getAllKeys();

                let items = [];
                let values = [];
                let keys = [];

                // Attendre que les deux requêtes soient terminées avant de créer le résultat
                transaction.oncomplete = function() {
                    // À ce stade, les deux requêtes sont terminées
                    keys = keysRequest.result;
                    values = allRequest.result;

                    items = values.map((item, index) => {
                        // Tenter de parser le JSON
                        let parsedItem = item;
                        try {
                            if (typeof item === 'string' &&
                                (item.startsWith('{') || item.startsWith('['))) {
                                parsedItem = JSON.parse(item);
                            }
                        } catch (e) {
                            // Garder en string si l'analyse échoue
                        }

                        return {
                            filename: keys[index],
                            data: parsedItem
                        };
                    });

                    const result = { success: true, items: items };
                    idb_listener('list', result);
                };

                allRequest.onerror = function(event) {
                    const error = new Error(`List error: ${event.target.error?.message || "unknown"}`);
                    idb_listener('list', { success: false, error: error.message });
                };

                keysRequest.onerror = function(event) {
                    const error = new Error(`List keys error: ${event.target.error?.message || "unknown"}`);
                    idb_listener('list', { success: false, error: error.message });
                };

            } catch (error) {
                idb_listener('list', { success: false, error: error.message });
            }
        })
        .catch(error => {
            idb_listener('list', { success: false, error: error.message });
        });
}

// Supprimer des données
function idb_remove(dbname, filename) {
    const dbToUse = db ? db.name : dbname;

    _openDatabase(dbToUse)
        .then(database => {
            try {
                const transaction = database.transaction([STORE_NAME], 'readwrite');
                const store = transaction.objectStore(STORE_NAME);
                const deleteRequest = store.delete(filename);

                deleteRequest.onerror = function(event) {
                    const error = new Error(`Delete error: ${event.target.error?.message || "unknown"}`);
                    idb_listener('remove', { success: false, error: error.message });
                };

                deleteRequest.onsuccess = function() {
                    const result = { success: true, filename };
                    idb_listener('remove', result);
                };
            } catch (error) {
                idb_listener('remove', { success: false, error: error.message });
            }
        })
        .catch(error => {
            idb_listener('remove', { success: false, error: error.message });
        });
}

// Réinitialiser la base de données
function idb_reset(dbname) {
    if (db) {
        db.close();
        db = null;
    }

    console.log(`Tentative de suppression de la base de données '${dbname}'...`);

    const deleteRequest = indexedDB.deleteDatabase(dbname);

    deleteRequest.onerror = function(event) {
        const error = new Error(`Reset error: ${event.target.error?.message || "unknown"}`);
        console.error("Erreur lors de la suppression:", error);
        idb_listener('reset', { success: false, error: error.message });
    };

    deleteRequest.onsuccess = function() {
        console.log(`Base de données '${dbname}' supprimée avec succès`);
        const result = { success: true, dbname };
        idb_listener('reset', result);
    };

    deleteRequest.onblocked = function() {
        console.warn(`La suppression de '${dbname}' est bloquée - d'autres connexions sont ouvertes`);
        const warning = "DB reset blocked, closing connections...";
        idb_listener('reset', { success: true, warning, dbname });

        // Attendre un peu et réessayer
        setTimeout(() => {
            console.log("Nouvelle tentative de suppression...");
            if (db) {
                db.close();
                db = null;
            }
            reset(dbname);
        }, 1000);
    };
}

// setTimeout(() => {
//     idb_save('my_file', 'my test');
//     // alert('kool');
//     setTimeout(() => {
//         idb_load('my_file');
//         // alert('kool');
//
//     }, 500);
//
// }, 3000);


