class VideoHelper {


    addVideoPlayer(parentId, controls) {
        const videoElement = $('<video />', {
            controls: controls
        });
        videoElement.appendTo($('#'+parentId));
        return videoElement[0];
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

    playVideo(atome_id, options, timerListener) {
        const media = $("#" + atome_id + ' video:first-child')[0];
        if (options === true || options === 'true') {
            options = 0;
        }
        media.addEventListener("timeupdate", function () {
            Opal.Events.$playing(timerListener, media.currentTime);
        });
        //media.currentTime is run twice, because if not depending on the context it may not be interpreted
        media.currentTime = options;
        media.addEventListener('loadedmetadata', function () {
            media.currentTime = options;
        }, false);
        media.play();
    }
}