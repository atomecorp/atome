class FileHelper {
    constructor(nbBytesRequested, fileSystemPermissionEventListener) {
        this.nbBytesRequested = nbBytesRequested;
        this.fileSystemPermissionEventListener = fileSystemPermissionEventListener;
    }

    connect() {
        const self = this;
        window.requestFileSystem(window.PERSISTENT,
            this.nbBytesRequested,
            function (fs) {
                self.fs = fs;
                self.fileSystemPermissionEventListener.onPermissionAccepted();
            },
            this.fileSystemPermissionEventListener.onPermissionDenied);
    }

    createFile(fileName, inputFile, fileEventListener) {
        this.fs.root.getFile("/" + fileName, {create: true}, function (fileEntry) {
            fileEntry.createWriter(function (fileWriter) {
                fileWriter.onwriteend = function () {
                    fileEventListener.success(this.fs);
                };

                fileWriter.write(inputFile);
                // fileWriter.write("koolllll");
            }, fileEventListener.error);
        });
    }

    getUrl(fileName, callback) {
        this.fs.root.getFile(fileName, {create: false, exclusive: false}, function (fileEntry) {
            const url = fileEntry.toURL();
            // var toto=url.replace('file:///', 'cdvfile://');
            // // file:///persistent/image.png
            // alert(toto);
            callback(url);
        });
    }

     // read_file(file_name, callback) {
     //
     //     var type = window.PERSISTENT;
     //     var size = 5 * 1024 * 1024;
     //     window.requestFileSystem(type, size, successCallback, errorCallback);
     //
     // }


}



// ///////////////////////////////////////
// var file_separator="."
//
// /////// create file ///////
// function create_file(file_name) {
//     var type = window.PERSISTENT;
//     var size = 5 * 1024 * 1024;
//     window.requestFileSystem(type, size, successCallback, errorCallback);
//
//     function successCallback(fs) {
//         fs.root.getFile(file_name, {create: true, exclusive: true}, function (fileEntry) {
//         }, errorCallback);
//     }
//
//     function errorCallback(error) {
//         console.log("File already exist !!! ERROR: " + error.code);
//     }
// }
//
//
// /////// write file ///////
// function write_file(file_name, file_content) {
//
//     // console.log(file_name+ "maybe transform the file_content in json to be able to read assets files");
//     var type = window.PERSISTENT;
//     var size = 5 * 1024 * 1024;
//     window.requestFileSystem(type, size, successCallback, errorCallback);
//     function successCallback(fs) {
//         fs.root.getFile(file_name, {create: true}, function (fileEntry) {
//             fileEntry.createWriter(function (fileWriter) {
//                 fileWriter.onwriteend = function (e) {
//                 };
//                 fileWriter.onerror = function (e) {
//                     console.log('Write failed: ' + e.toString());
//                 };
//                 //////////////
//                 if (file_content instanceof Blob){
//                     fileWriter.write(file_content);
//                 }
//                 else {
//                     var blob = new Blob([file_content], {type: 'text/plain'});
//                     //  var blob = new Blob([file_content], {type: file_content.type});
//                     fileWriter.write(blob);
//                 }
//                 //////////////
//                 // if (call != false) {
//                 //     // Opal.eval(call + "('" + params + "')");c
//                 // }
//             }, errorCallback);
//         }, errorCallback);
//     }
//
//     function errorCallback(error) {
//         console.log("ERROR: " + error.code);
//     }
// }
//
// /////// read file ///////
// // usage  the first param "file_name" is used to get the file if it succeed it run the function passed in the "call" params, the third param "params" is used to passed params  to the function , the fourth and last params is used in case of a file not found error then if run the function passed in the params: "err_callb_fct"
// function read_file(file_name, call, params, err_callb_fct) {
//     var type = window.PERSISTENT;
//     var size = 5 * 1024 * 1024;
//     window.requestFileSystem(type, size, successCallback, errorCallback);
//
//     function successCallback(fs) {
//         fs.root.getFile(file_name, {}, function (fileEntry) {
//             fileEntry.file(function (file) {
//                 var reader = new FileReader();
//                 reader.onloadend = function (e) {
//                     var file_content = this.result;
//                     file_content = file_content.replace(/'/g, "\\'");
//                     file_content= protect_accent(file_content);
//                     if (params == "") {
//                         Opal.eval(call + "('" + file_content + "')");
//                     } else {
//                         Opal.eval(call + "('" + file_content + "','" + params + "')");
//                     }
//                 };
//                 reader.readAsText(file);
//             }, errorCallback2);
//         }, errorCallback);
//     }
//
//     function errorCallback2(err) {
//         console.log("file call is : " + file_name + "ERROR: maybe crash " + err.code);
//     }
//
//     function errorCallback(error) {
//         try {
//             Opal.eval(err_callb_fct);
//         } catch (err) {
//             console.error(err);
//         }
//     }
// }
//
// /////// remove file ///////
// function remove_file(file_name) {
//     file_name=Opal.Atome.$human()+file_separator+file_name;
//     var type = window.PERSISTENT;
//     var size = 5 * 1024 * 1024;
//     window.requestFileSystem(type, size, successCallback, errorCallback);
//     function successCallback(fs) {
//         fs.root.getFile(file_name, {create: false}, function (fileEntry) {
//             fileEntry.remove(function () {
//                 console.log("File: " + file_name + " was removed.");
//             }, errorCallback);
//         }, errorCallback);
//     }
//
//     function errorCallback(error) {
//         console.log("ERROR: " + error.code);
//     }
// }
//
//
// //////////// Test for Write/Read medias
//
//
// function read_file_test(file_name, call, params, err_callb_fct) {
//     var type = window.PERSISTENT;
//     var size = 5 * 1024 * 1024;
//     window.requestFileSystem(type, size, successCallback, errorCallback);
//
//     function successCallback(fs) {
//         fs.root.getFile(file_name, {}, function (fileEntry) {
//             fileEntry.file(function (file) {
//
//                 alert(fileEntry.toURL());
//                 alert(fileEntry.toInternalURL())
//                 $( "#output" ).remove();
//                 $("body").append('<img id="output"  width="100" height="100" />');
//                 $("#output").css("z-index",50000);
//                 $("#output").css("position","absolute");
//
//                 resolveLocalFileSystemURL('cdvfile://localhost/persistent/cloud-SFR.jpg', function(entry) {
//                     var nativePath = entry.toInternalURL();
//                     console.log('Native URI: ' + nativePath);
//                     document.getElementById('output').src = nativePath;
//                 });
//
//                 // var reader = new FileReader();
//                 // reader.onloadend = function (e) {
//                 //     var file_content = this.result;
//                 //     //alert (file_content);
//                 //     //import_visual_medias(undefined , new Blob([file_content], {type: 'image/jpeg'}));
//                 //     // file_content = file_content.replace(/'/g, "\\'");
//                 //     // if (params == "") {
//                 //     //     Opal.eval(call + "('" + file_content + "')");
//                 //     // } else {
//                 //     //     Opal.eval(call + "('" + file_content + "','" + params + "')");
//                 //     // }
//                 //     // if (call == "add_to_screen") {
//                 //     //     //we change the project_on_screen var to the new project name
//                 //     //     file_name = file_name.split(file_separator)[1];
//                 //     //     Opal.Atome.$project_on_screen(file_name);
//                 //     //     Opal.Object.$project_list_send_to_set_last_project();
//                 //     // }
//                 //
//                 // };
//                 // reader.readAsArrayBuffer(file);
//             }, errorCallback2);
//         }, errorCallback);
//     }
//
//     function errorCallback2(err) {
//         console.log("file call is : " + file_name + "ERROR: maybe crash " + err.code);
//     }
//
//     function errorCallback(error) {
//         try {
//             Opal.eval(err_callb_fct);
//         } catch (err) {
//             console.error(err);
//         }
//     }
// }
