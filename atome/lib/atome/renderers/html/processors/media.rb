module ProcessorHtml
  def video_creator_helper(value)
    video_found = find({ type: :video, scope: :eden, name: value })
    path = if video_found.nil?
             "././medias/videos/video_missing.mp4"
           else
             video_found[:path]
           end
    jq_get(atome_id).create_video(atome_id)
    jq_get(atome_id).find("video").html("<source src=" + path + " type='video/mp4'></source>")
    # playsinline below is used to prevent ios to play video fullscreen by defaulr
    jq_get(atome_id).find("video").attr('playsinline', '')
    unless width
      self.width = jq_get(atome_id).find("video").width
    end
    unless height
      self.height = jq_get(atome_id).find("video").height
    end
    jq_get(atome_id).find("video").css("height", "100%")
    jq_get(atome_id).find("video").css("width", "100%")
  end

  def audio_creator_helper(value)
    audio_found = find({ type: :audio, scope: :eden, name: value })
    path = if audio_found.nil?
             "././medias/audios/audio_missing.wav"
           else
             audio_found[:path]
           end
    jq_get(atome_id).create_audio(atome_id)
    jq_get(atome_id).find("audio").html("<source  src=" + path + " type='audio/wav'></source>")

    unless width
      self.width = jq_get(atome_id).find("audio").width
    end
    unless height
      self.height = jq_get(atome_id).find("audio").height
    end
    jq_get(atome_id).find("audio").css("height", "100%")
    jq_get(atome_id).find("audio").css("width", "100%")
  end

  def image_creator_helper(value)
    image_found = find({ type: :image, scope: :eden, name: value })
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
    self.ratio(self.width / self.height)
    jq_get(atome_id).css("background-image", "url(#{path})")
    jq_get(atome_id).css("background-size", "100% 100%")
  end

  class_variable_set("@@http", Http.new) # you can access without offense

  def reader(filename, &proc)
    #  read remote file
    if filename.instance_of?(Array)
      filename.each do |file|
        @@http.get(file, &proc)
      end
    else
      @@http.get(filename, &proc)
    end
  end

  def path_getter_helper(value)
    image_found = find({ type: :image, scope: :eden, name: value })
    if image_found.nil?
      path_found = "././medias/images/image_missing.svg"
    else
      path_found = image_found[:path]
    end
    reader(path_found) do |data|
      if width.nil?
        self.width = image_found[:width]
      end
      if height.nil?
        self.height = image_found[:height]
      end
      self.ratio(self.width / self.height)
      # jq_get(atome_id).css("background-image", "linear-gradient(0deg, transparent, transparent)")
      # jq_get(atome_id).css("background-color", :transparent)
      jq_get(atome_id).append(data)
    end
  end

  def camera_creator_helper
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