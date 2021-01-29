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
            }, fileEventListener.error);
        });
    }

    getUrl(fileName, callback) {
        this.fs.root.getFile("/" + fileName, {create: false, exclusive: false}, function (fileEntry) {
            const url = fileEntry.toURL();
            callback(url);
        });
    }
}