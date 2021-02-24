class MediaHelper {
    constructor(width, height, framerate, previewElement, playbackElement, recordingEventListener) {
        this.width = width;
        this.height = height;
        this.framerate = framerate;
        this.previewElement = previewElement;
        this.playbackElement = playbackElement;

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

                self.previewElement.srcObject = self.localStream;
                self.previewElement.play();

                self.mediaRecorder = new MediaRecorder(self.localStream);

                self.mediaRecorder.onerror = function (err) {
                    self.recordingEventListener.onError(err);
                };

                self.mediaRecorder.onstop = function () {
                    const recording = new Blob(self.chunks);
                    self.playbackElement.src = URL.createObjectURL(recording);
                    self.playbackElement.play();
                };

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
}