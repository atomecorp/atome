module ProcessorHtml
  def video_creator_helper(value)
    video_found = find({type: :video, scope: :eden, name: value})
    path = if video_found.nil?
             "././medias/videos/video_missing.mp4"
           else
             video_found[:path]
           end
    jq_get(atome_id).create_video(atome_id)
    jq_get(atome_id).find("video").html("<source src=" + path + " type='video/mp4'></source>")
    unless width
      self.width = jq_get(atome_id).find("video").width
    end
    unless height
      self.height = jq_get(atome_id).find("video").height
    end
    jq_get(atome_id).find("video").css("width", "100%")
  end

  def image_creator_helper(value)
    image_found = find({type: :image, scope: :eden, name: value})
    if image_found.nil?
      path = "././medias/images/image_missing.svg"
    else
      path = image_found[:path]
      if width.nil?
        self.width = image_found[:width]
      end
      if height.nil?
        self.height = image_found[:height]
      end
    end
    jq_get(atome_id).css("background-image", "url(#{path})")
    jq_get(atome_id).css("background-size", "100% 100%")
  end

  def camera_creator_helper(value)
    `
    let mediaEventListener = {
        onReady: function (recorderHelper) {
          // Start preview on created video player.
          recorderHelper.startPreview(inputVideo);
        },
        onError: function (recorderHelper, error) {
          console.log(error);
        },
        onStop: function (recorderHelper, recording) {
          const playbackVideo = videoHelper.addVideoPlayer('view', false);
          recorderHelper.playRecording(playbackVideo, recording);
        }
    };

    const width = parseInt($("#"+#{atome_id}).css('width'));
    const height = parseInt($("#"+#{atome_id}).css('height'));
videoHelper=new VideoHelper
recorderHelper = new RecorderHelper(width, height, 60, mediaEventListener);
    // Create video player
    const inputVideo = videoHelper.addVideoPlayer(#{atome_id}, false);
    `
  end

end