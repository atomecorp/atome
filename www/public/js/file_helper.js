class FileHelper {
    constructor(nbBytesRequested, fileSystemPermissionEventListener) {
        this.fileSystemPermissionEventListener = fileSystemPermissionEventListener;
    }

    connect() {
        window.requestFileSystem(window.PERSISTENT,
            this.nbBytesRequested,
            this.fileSystemPermissionEventListener.onPermissionAccepted,
            this.fileSystemPermissionEventListener.onPermissionDenied);
    }

    createFile(inputFile, fileEventListener) {
        window.resolveLocalFileSystemURL(cordova.file.dataDirectory, function (dir) {
            dir.getFile("/image.png", {create: true}, function (file) {
                file.createWriter(function (fileWriter) {
                    fileWriter.onwriteend = function () {
                        fileEventListener.success(fs);
                    };

                    fileWriter.write(inputFile);
                }, fileEventListener.error);
            });
        });
    }
}