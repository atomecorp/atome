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
    alert(result);
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

function importer(){

    // Gestionnaire pour le drag and drop de fichiers
    document.body.addEventListener('dragover', function(e) {
        e.preventDefault(); // Nécessaire pour autoriser le drop
        // Modifier le style si nécessaire
    });

    document.body.addEventListener('drop', function(e) {
        e.preventDefault();
        let files = e.dataTransfer.files; // Obtention de la liste des fichiers déposés

        if (files.length) {
            // Parcourir chaque fichier
            for (let i = 0; i < files.length; i++) {
                let file = files[i];
                let reader = new FileReader();

                // Lire le fichier en tant que texte
                reader.readAsText(file);

                // Événement déclenché une fois la lecture terminée
                reader.onload = function() {
                    console.log('Contenu du fichier #' + (i + 1));
                    console.log('Nom: ' + file.name);
                    console.log('Type: ' + file.type);
                    console.log('Taille: ' + file.size + ' octets');
                    console.log('Contenu: \n' + reader.result); // Affichage du contenu du fichier
                };

                // Gestion des erreurs de lecture
                reader.onerror = function() {
                    console.error('Erreur de lecture du fichier: ' + file.name);
                };
            }
        }
        // if (e.dataTransfer.files.length) {
        //     alert (e.dataTransfer.files);
        //     // Traiter les fichiers déposés
        // }
    });

// Gestionnaire pour les éléments div
    var divs = document.querySelectorAll('.draggable-div');
    divs.forEach(function(div) {
        div.addEventListener('dragstart', function(e) {
            e.dataTransfer.setData('text/plain', 'some-data');
            e.stopPropagation(); // Empêcher la propagation au body
        });
    });

}

importer()


function exception_import (){
    // Sélectionner la div spéciale par son ID
    var specialDiv = document.getElementById('my_box');

// Gestionnaire d'événements pour la 'special-div' pour le drag over
    specialDiv.addEventListener('dragover', function(e) {

        specialDiv.style.backgroundColor= 'red';
        e.preventDefault(); // Prévenir le comportement par défaut
        e.stopPropagation(); // Arrêter la propagation de l'événement
    });
    specialDiv.addEventListener('dragleave', function(e) {
        specialDiv.style.backgroundColor = 'yellow'; // Réinitialiser la couleur de fond lors du drag out
        e.stopPropagation(); // Arrêter la propagation de l'événement
    });
// Gestionnaire d'événements pour la 'special-div' pour le drop
    specialDiv.addEventListener('drop', function(e) {
        e.preventDefault(); // Prévenir le comportement par défaut
        e.stopPropagation(); // Arrêter la propagation de l'événement

        // Traitement spécifique pour les fichiers déposés sur la 'special-div'
        console.log('Fichier déposé dans la zone spéciale');
    });

// Gestionnaire d'événements pour le body pour le drop
    document.body.addEventListener('drop', function(e) {
        e.preventDefault(); // Prévenir le comportement par défaut

        // Traitement pour les fichiers déposés en dehors de la 'special-div'
        console.log('Fichier déposé hors de la zone spéciale');
    });


}
setTimeout(function () {
    exception_import();
console.log('ready');
}, 3000);
