class MediaStreamingHelper {
    constructor(
        {
            server,
            port,
            channelId,
            peerId
        }
    ) {
        this.url = "wss://" + server + ":" + port + "/?roomId=" + channelId + "&peerId=" + peerId;
        this.socket = null;
        this.callbacks = [];
        this._mediasoupDevice = null;
        this._sendTransport = null;
        this._recvTransport = null;
    }

    join(audioTrackCallback, videoTrackCallback, microphoneCallback, cameraCallback, serverErrorCallback) {
        this.socket = new WebSocket(this.url, "protoo");

        const self = this;
        this.socket.onopen = () => {
            self._joinRoom(microphoneCallback, cameraCallback);
        };

        this.socket.onmessage = function (event) {
            const eventData = JSON.parse(event.data);

            switch (eventData.method) {
                case 'newConsumer': {
                    const {
                        peerId,
                        producerId,
                        id,
                        kind,
                        rtpParameters,
                        appData
                    } = eventData.data;

                    const eventId = eventData.id;

                    self._recvTransport.consume(
                        {
                            id,
                            producerId,
                            kind,
                            rtpParameters,
                            appData: {...appData, peerId}
                        }).then((consumer) => {

                        self.socket.send(JSON.stringify(
                            {
                                "id": eventId,
                                "ok": true,
                                "response": true,
                                "data": {}
                            }));

                        if (consumer.track.kind === 'audio') {
                            audioTrackCallback(consumer.track);
                        } else if (consumer.track.kind === 'video') {
                            videoTrackCallback(consumer.track);
                        }
                    });

                    break;
                }
            }

            const callback = self.callbacks[eventData.id];
            if (callback !== undefined) {
                callback(eventData);
            }
        };

        this.socket.onError = function (error) {
            serverErrorCallback(error);
        };
    }

    _joinRoom(microphoneCallback, cameraCallback) {
        this._mediasoupDevice = new window.mediasoup.Device();

        const message = {
            request: true,
            id: this._generateRandomNumber(),
            method: "getRouterRtpCapabilities",
            data: {}
        };

        this._sendRequest(message, (response) => {
            const routerRtpCapabilities = response.data;
            this._mediasoupDevice.load({routerRtpCapabilities});

            const message = {
                request: true,
                id: this._generateRandomNumber(),
                method: "createWebRtcTransport",
                data: {
                    "producing": true
                }
            };
            this._sendRequest(message, (response) => {
                const producerTransportInfo = response.data;
                this._sendTransport = this._mediasoupDevice.createSendTransport(producerTransportInfo);

                this._sendTransport.on(
                    'connect', ({dtlsParameters}, callback) => {
                        const message = {
                            request: true,
                            id: this._generateRandomNumber(),
                            method: "connectWebRtcTransport",
                            data: {
                                "transportId": this._sendTransport.id,
                                dtlsParameters
                            }
                        };
                        this._sendRequest(message, () => {
                            callback();
                        });
                    });

                this._sendTransport.on(
                    'produce', async ({kind, rtpParameters, appData}, callback) => {
                        const message = {
                            request: true,
                            id: this._generateRandomNumber(),
                            method: "produce",
                            data: {
                                "transportId": this._sendTransport.id,
                                kind,
                                rtpParameters,
                                appData
                            }
                        };
                        this._sendRequest(message, (response) => {
                            const {id} = response.data;

                            callback(id);
                        });
                    });

                this._sendTransport.on('producedata', async (
                    {
                        sctpStreamParameters,
                        label,
                        protocol,
                        appData
                    },
                    callback
                ) => {
                    const message = {
                        "request": true,
                        "id": this._generateRandomNumber(),
                        "method": "produceData",
                        "data": {
                            "transportId": this._sendTransport.id,
                            sctpStreamParameters,
                            label,
                            protocol,
                            appData
                        }
                    };
                    this._sendRequest(message, (response) => {
                        const {id} = response.data;

                        callback({id});
                    });
                });

                const message = {
                    "request": true,
                    "id": this._generateRandomNumber(),
                    "method": "createWebRtcTransport",
                    "data": {
                        "consuming": true
                    }
                };
                this._sendRequest(message, (response) => {
                    const consumerTransportInfo = response.data;
                    this._recvTransport = this._mediasoupDevice.createRecvTransport(consumerTransportInfo);

                    this._recvTransport.on(
                        'connect', ({dtlsParameters}, callback) => {
                            const message = {
                                "request": true,
                                "id": this._generateRandomNumber(),
                                "method": "connectWebRtcTransport",
                                "data": {
                                    "transportId": this._recvTransport.id,
                                    dtlsParameters
                                }
                            };
                            this._sendRequest(message, () => {
                                callback();
                            });
                        });

                    const message = {
                        "request": true,
                        "id": this._generateRandomNumber(),
                        "method": "join",
                        "data": {
                            "rtpCapabilities": this._mediasoupDevice.rtpCapabilities
                        }
                    };
                    this._sendRequest(message, () => {
                        this._enableAudioStream(microphoneCallback);
                        this._enableVideoStream(cameraCallback);
                    });
                });
            });
        });
    }

    _sendRequest(message, callback) {
        this.callbacks[message.id] = callback;

        const json = JSON.stringify(message);
        this.socket.send(json);
    }

    _enableAudioStream(microphoneCallback) {
        navigator.mediaDevices.getUserMedia({audio: true}).then(audioStream => {
            const audioTrack = audioStream.getAudioTracks()[0];

            this._sendTransport.produce(
                {
                    track: audioTrack
                }
            ).catch(reason => {
                console.log('Cannot produce audio track. Reason: ' + reason);
            });
        }).catch(function(error) {
            microphoneCallback(error);
        });
    }

    _enableVideoStream(cameraCallback) {
        navigator.mediaDevices.getUserMedia({video: true}).then((videoStream) => {
            const videoTrack = videoStream.getVideoTracks()[0];

            this._sendTransport.produce(
                {
                    track: videoTrack
                }
            ).catch(reason => {
                console.log('Cannot produce video track. Reason: ' + reason);
            });
        }).catch(function(error) {
            cameraCallback(error);
        });
    }

    _generateRandomNumber() {
        return Math.round(Math.random() * 10000000);
    }
}
