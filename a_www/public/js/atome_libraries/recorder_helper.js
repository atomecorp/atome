class RecorderHelper {
    constructor(width, height, framerate, recordingEventListener) {
        this.width = width;
        this.height = height;
        this.framerate = framerate;
        this.recordingEventListener = recordingEventListener;

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

                self.mediaRecorder = new MediaRecorder(self.localStream);

                self.mediaRecorder.onerror = function (err) {
                    self.recordingEventListener.onError(self, err);
                };

                self.mediaRecorder.ondataavailable = function (e) {
                    self.chunks.push(e.data);
                };

                self.mediaRecorder.onstop = function (e) {
                    const recording = new Blob(self.chunks);
                    self.recordingEventListener.onStop(self, recording);
                };

                self.recordingEventListener.onReady(self);
            })
            .catch(function (err) {
                self.recordingEventListener.onError(err);
            });
    }

    // addVideoPlayer(parentId, controls) {
    //     const videoElement = $('<video />', {
    //         controls: controls
    //     });
    //     videoElement.appendTo($('#'+parentId));
    //     return videoElement[0];
    // }

    startPreview(previewElement) {
        previewElement.srcObject = this.localStream;
        previewElement.play();
    }

    startRecording() {
        this.mediaRecorder.start();
    }

    stopRecording() {
        this.mediaRecorder.stop();
    }

    playRecording(targetElement, recording) {
        targetElement.src = URL.createObjectURL(recording);
        targetElement.play();
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

    // playAudio(atome_id, options, proc) {
    //     const media = $("#" + atome_id + ' audio:first-child')[0];
    //     if (options === true || options === 'true') {
    //         options = 0;
    //     }
    //     media.addEventListener("timeupdate", function () {
    //         Opal.Event.$playing(proc, media.currentTime);
    //     });
    //     //media.currentTime is run twice, because if not depending on the context it may not be interpreted
    //     media.currentTime = options;
    //     media.addEventListener('loadedmetadata', function () {
    //         media.currentTime = options;
    //     }, false);
    //     media.play();
    // }
    //
    // playVideo(atome_id, options, timerListener) {
    //     const media = $("#" + atome_id + ' video:first-child')[0];
    //     if (options === true || options === 'true') {
    //         options = 0;
    //     }
    //     media.addEventListener("timeupdate", function () {
    //         Opal.Events.$playing(timerListener, media.currentTime);
    //     });
    //     //media.currentTime is run twice, because if not depending on the context it may not be interpreted
    //     media.currentTime = options;
    //     media.addEventListener('loadedmetadata', function () {
    //         media.currentTime = options;
    //     }, false);
    //     media.play();
    // }
}