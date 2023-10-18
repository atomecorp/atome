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


//////////////////// Baseshell  ///////////////////////
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
    rubyVMCallback("grab(:toto).left(3)");
    cmd_result = cmd_result.replace(/\r?\n/g, "");
    rubyVMCallback('A.' + callback_method + "('" + cmd_result + "')");
}

/////////////////// shelll ///////////////////////////

async function shell(atome_id, cmd) {
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
    // rubyVMCallback("grab(:"+atome_id+").data('"+cmd_result+"')");
    rubyVMCallback("grab(:" + atome_id + ").terminal_call('" + cmd_result + "')");

}


//////////////////// terminal  ///////////////////////

function distant_terminal(id, cmd) {
    let myd_data_test = 'terminal will soon be implemented for distant connection';
    let call_back_to_send = `grab(:${id}).callback({terminal: "${myd_data_test}"})`
    let call = `grab(:${id}).call(:terminal)`
    rubyVMCallback(call_back_to_send)
    rubyVMCallback(call)
}

async function terminal(id, cmd) {
    let cmd_result;
    try {
        const command = cmd;
        let response;
        response = await window.__TAURI__.invoke('execute_command', {command});
        cmd_result = response;
    } catch (error) {
        cmd_result = error;
    }
    // rubyVMCallback(callback_method, "('" + cmd_result + "')")
    cmd_result = cmd_result.replace(/\r?\n/g, "");
    // let call_back_to_send = `grab(:${id}).callback({terminal: "${cmd_result}"})`;
    let call = `grab(:${id}).call(:terminal)`
    rubyVMCallback(call)
    // rubyVMCallback("A.terminal_callback('" + cmd_result + "')")
}

// async function terminal(id, cmd) {
//     let cmd_result;
//     try {
//         const command = 'pwd';
//         let response;
//         response = await window.__TAURI__.invoke('execute_command', {command});
//         cmd_result = response;
//         cmd_result = cmd_result.replace(/\r?\n/g, "");
//         let call = `grab(:${id}).call(:terminal)`
//         let call_back_to_send = `grab(:${id}).callback({terminal: "${cmd_result}"})`;
//         rubyVMCallback(call_back_to_send);
//         rubyVMCallback(call);
//         alert('ok');
//     } catch (error) {
//         cmd_result = error;
//     }
//
//
//     // rubyVMCallback(call_back_to_send);
//     // rubyVMCallback(call);
//
//     // let myd_data_test = 'terminal will soon be implemented for distant connection';
//     // let call_back_to_send = `grab(:${id}).callback({terminal: "${myd_data_test}"})`
//     // let call = `grab(:${id}).call(:terminal)`
//     // rubyVMCallback(call_back_to_send)
//     // rubyVMCallback(call)
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
