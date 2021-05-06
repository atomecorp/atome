class VideoHelper {

    addVideoPlayer(parentId, controls) {
        const videoElement = $('<video />', {
            controls: controls
        });
        videoElement.appendTo($('#' + parentId));
        return videoElement[0];
    }


    addAudioPlayer(parentId, controls) {
        const audioElement = $('<audio />', {
            controls: controls
        });
        audioElement.appendTo($('#' + parentId));
        return audioElement[0];
    }

    playMedia(media, atome_id, options, proc) {
        if (options === 'play' || typeof (options) == 'number') {
            if(typeof (options)=='string'){
                media.currentTime = 0;
            }
            else{
                media.currentTime = options;
            }
            media.play();
            media.addEventListener("timeupdate", function () {
                Opal.JSUtils.$js_play_callback(media.currentTime, proc);
            });
        } else if (options === 'pause') {
            Opal.JSUtils.$js_play_set_instance_variable(atome_id, media.currentTime);
            media.pause();
        } else if (options === 'stop') {
            Opal.JSUtils.$js_play_set_instance_variable(atome_id, 0);
            media.pause();
            media.currentTime = 0;
        }
    }

    playAudio(atome_id, options, proc) {
        const media = $("#" + atome_id + ' audio')[0];
        this.playMedia(media, atome_id, options, proc);
    }

    playVideo(atome_id, options, proc) {
        const media = $("#" + atome_id + ' video')[0];
        this.playMedia(media, atome_id, options, proc);

    }
}