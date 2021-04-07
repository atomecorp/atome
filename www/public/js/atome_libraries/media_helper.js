class MediaHelper {
    constructor(width, height, framerate, inputVideo, recordingEventListener) {
        this.width = width;
        this.height = height;
        this.framerate = framerate;
        this.inputVideo = inputVideo;
        // this.playbackElement = playbackElement;
        this.recordingEventListener = recordingEventListener;
    }

    connect() {
        if (!navigator.mediaDevices) {
            this.recordingEventListener.onError("Media devices is not supported");
            return;
        }

        const constraints = {
            audio: true,
            video: {
                width: {min: this.width, ideal: this.width, max: this.width},
                height: {min: this.height, ideal: this.height, max: this.height},
                framerate: this.framerate
            }
        };
        this.chunks = [];

        const self = this;

        navigator.mediaDevices.getUserMedia(constraints)
            .then(function (stream) {
                self.localStream = stream;

                self.inputVideo.srcObject = self.localStream;
                self.inputVideo.play();

                self.mediaRecorder = new MediaRecorder(self.localStream);

                self.mediaRecorder.onerror = function (err) {
                    self.recordingEventListener.onError(err);
                };

                // self.mediaRecorder.onstop = function () {
                //     const recording = new Blob(self.chunks);
                //     self.playbackElement.src = URL.createObjectURL(recording);
                //     self.playbackElement.play();
                // };

                self.mediaRecorder.ondataavailable = function (e) {
                    self.chunks.push(e.data);
                };

                self.recordingEventListener.onConnected();
            })
            .catch(function (err) {
                self.recordingEventListener.onError(err);
            });
    }

    start() {
        this.mediaRecorder.start();
    }

    stop() {
        this.mediaRecorder.stop();
    }

    pause() {
        this.mediaRecorder.pause();
        this.isPaused = true;
    }

    resume() {
        this.isPaused = false;
        this.mediaRecorder.resume();
    }

    pauseOrResume() {
        if(this.isPaused) {
            resume();
        } else {
            pause();
        }
    }
    // constructor(width, height, framerate, recordingEventListener) {
    //     this.width = width;
    //     this.height = height;
    //     this.framerate = framerate;
    //     this.recordingEventListener = recordingEventListener;
    // }
    //
    // connect(previewElement, playbackElement) {
    //     if (!navigator.mediaDevices) {
    //         this.recordingEventListener.onError("Media devices is not supported");
    //         return;
    //     }
    //
    //     const constraints = {
    //         audio: true,
    //         video: {
    //             width: {min: this.width, ideal: this.width, max: this.width},
    //             height: {min: this.height, ideal: this.height, max: this.height},
    //             framerate: this.framerate
    //         }
    //     };
    //     this.chunks = [];
    //
    //     const self = this;
    //
    //     navigator.mediaDevices.getUserMedia(constraints)
    //         .then(function (stream) {
    //             self.localStream = stream;
    //
    //             previewElement.srcObject = self.localStream;
    //             previewElement.play();
    //
    //             self.mediaRecorder = new MediaRecorder(self.localStream);
    //
    //             self.mediaRecorder.onerror = function (err) {
    //                 self.recordingEventListener.onError(err);
    //             };
    //
    //             self.mediaRecorder.onstop = function () {
    //                 const recording = new Blob(self.chunks);
    //                 playbackElement.src = URL.createObjectURL(recording);
    //                 playbackElement.play();
    //             };
    //
    //             self.mediaRecorder.ondataavailable = function (e) {
    //                 self.chunks.push(e.data);
    //             };
    //
    //             self.recordingEventListener.onConnected();
    //         })
    //         .catch(function (err) {
    //             self.recordingEventListener.onError(err);
    //         });
    // }
    //
    addImage(parent, url) {
        const randomId = Math.random().toString(16).substr(2, 32);
        $('#'+parent).append('<img id="' + randomId + '"  width="500" height="600">');
        const output = document.getElementById(randomId);
        output.src = url;
    }

    addVideoPlayer(parentId, controls) {
        const videoElement = $('<video />', {
            controls: controls
        });
        videoElement.appendTo($('#'+parentId));
    }

    startRecording() {
        this.mediaRecorder.start();
    }

    stopRecording() {
        this.mediaRecorder.stop();
    }

    pauseRecording() {
        this.mediaRecorder.pause();
        this.isPaused = true;
    }

    resumeRecording() {
        this.isPaused = false;
        this.mediaRecorder.resume();
    }

    pauseOrResumeRecording() {
        if(this.isPaused) {
            this.resume();
        } else {
            this.pause();
        }
    }

    playAudio(atome_id, options, proc) {
        const media = $("#" + atome_id + ' audio:first-child')[0];
        if (options === true || options === 'true') {
            options = 0;
        }
        media.addEventListener("timeupdate", function () {
            Opal.Event.$playing(proc, media.currentTime);
        });
        //media.currentTime is run twice, because if not depending on the context it may not be interpreted
        media.currentTime = options;
        media.addEventListener('loadedmetadata', function () {
            media.currentTime = options;
        }, false);
        media.play();
    }

    playVideo(atome_id, options, proc) {
        const media = $("#" + atome_id + ' video:first-child')[0];
        if (options === true || options === 'true') {
            options = 0;
        }
        media.addEventListener("timeupdate", function () {
            Opal.Events.$playing(proc, media.currentTime);
        });
        //media.currentTime is run twice, because if not depending on the context it may not be interpreted
        media.currentTime = options;
        media.addEventListener('loadedmetadata', function () {
            media.currentTime = options;
        }, false);
        media.play();
    }
}

// class MediaHelper {
//     constructor(width, height, framerate, previewElement, playbackElement, recordingEventListener) {
//         this.width = width;
//         this.height = height;
//         this.framerate = framerate;
//         this.previewElement = previewElement;
//         this.playbackElement = playbackElement;
//
//         this.recordingEventListener = recordingEventListener;
//     }
//
//     connect() {
//         if (!navigator.mediaDevices) {
//             this.recordingEventListener.onError("Media devices is not supported");
//             return;
//         }
//
//         const constraints = {
//             audio: true,
//             video: {
//                 width: {min: this.width, ideal: this.width, max: this.width},
//                 height: {min: this.height, ideal: this.height, max: this.height},
//                 framerate: this.framerate
//             }
//         };
//         this.chunks = [];
//
//         const self = this;
//
//         navigator.mediaDevices.getUserMedia(constraints)
//             .then(function (stream) {
//                 self.localStream = stream;
//
//                 self.previewElement.srcObject = self.localStream;
//                 self.previewElement.play();
//
//                 self.mediaRecorder = new MediaRecorder(self.localStream);
//
//                 self.mediaRecorder.onerror = function (err) {
//                     self.recordingEventListener.onError(err);
//                 };
//
//                 self.mediaRecorder.onstop = function () {
//                     const recording = new Blob(self.chunks);
//                     self.playbackElement.src = URL.createObjectURL(recording);
//                     self.playbackElement.play();
//                 };
//
//                 self.mediaRecorder.ondataavailable = function (e) {
//                     self.chunks.push(e.data);
//                 };
//
//                 self.recordingEventListener.onConnected();
//             })
//             .catch(function (err) {
//                 self.recordingEventListener.onError(err);
//             });
//     }
//
//     start() {
//         this.mediaRecorder.start();
//     }
//
//     stop() {
//         this.mediaRecorder.stop();
//     }
//
//     pause() {
//         this.mediaRecorder.pause();
//         this.isPaused = true;
//     }
//
//     resume() {
//         this.isPaused = false;
//         this.mediaRecorder.resume();
//     }
//
//     pauseOrResume() {
//         if(this.isPaused) {
//             resume();
//         } else {
//             pause();
//         }
//     }
// }