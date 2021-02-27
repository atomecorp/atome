module MediasProcessors
  # todo :it'll certainly be better if meta programmed
  def box_processor(value)
    box = Object.box(value)
    box.parent = atome_id
  end

  def box_getter_processor(value)
    alert "processor media line 7 : #{value}get the box if needed to be created"
    #  box()
  end

  def circle_processor(value)
    circle = Object.circle(value)
    circle.parent = atome_id
  end

  def circle_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  circle()
  end

  def text_processor(value)
    text = Object.text(value)
    text.parent = atome_id
  end

  def text_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  text()
  end

  def image_processor(value)
    image = Object.image(value)
    image.parent = atome_id
  end

  def image_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  image()
  end

  def video_processor(value)
    video = Object.video(value)
    video.parent = atome_id
  end

  def video_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  video()
  end

  def audio_processor(value)
    audio = Object.audio(value)
    audio.parent = atome_id
  end

  def audio_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  audio()
  end
end