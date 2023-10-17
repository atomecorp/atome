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

//call greet test
// async function callGreet() {
//     try {
//         const response = await window.__TAURI__.invoke('greet', { name: 'John' });
//         console.log(response); // Cela affichera la réponse dans la console
//     } catch (error) {
//         console.error(error);
//     }
// }
//
// callGreet();

//Send shell command

//////////////////// shell  ///////////////////////
async function callExecuteCommand(callback_method, cmd) {
    let cmd_result;
    try {
        const command = cmd;
        let response;
        response = await window.__TAURI__.invoke('execute_command', {command});
        cmd_result = response;
    } catch (error) {
        cmd_result = error;
    }
    rubyVMCallback(callback_method, "('" + cmd_result + "')")
}

//////////////////// terminal  ///////////////////////

function terminal(cmd) {
    callback('terminal', cmd)
}

////////////////////

// async function callExecuteCommand(comd) {
//     let cmd_result;
//     try {
//         const command = comd; // Remplacez ceci par votre commande shell souhaitée
//         const response = await window.__TAURI__.invoke('execute_command', {command});
//         cmd_result = response;
//         // console.log(response); // Cela affichera la sortie de la commande ou l'erreur dans la console
//     } catch (error) {
//         // console.error(error);
//         cmd_result = error;
//     }
//     // alert('callback' + cmd_result)
//     // return cmd_result;
//     rubyVMCallback('puts '+"'"+cmd_result+"'")
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
