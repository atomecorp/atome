module MediasProcessors
  # todo :it'll certainly be better if meta programmed
  def box_processor(value)
    atome = Object.box(value)
    atome.parent = atome_id
    atome
  end

  def box_getter_processor(value)
    alert "processor media line 7 : #{value}get the box if needed to be created"
    #  box()
  end

  def circle_processor(value)
    atome = Object.circle(value)
    atome.parent = atome_id
    atome
  end

  def circle_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  circle()
  end

  def text_processor(value)
    atome = Object.text(value)
    atome.parent = atome_id
    atome
  end

  def text_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  text()
  end

  def image_processor(value)
    atome = Object.image(value)
    atome.parent = atome_id
    atome
  end

  def image_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  image()
  end

  def video_processor(value)
    atome = Object.video(value)
    atome.parent = atome_id
    atome
  end

  def video_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  video()
  end

  def audio_processor(value)
    atome = Object.audio(value)
    atome.parent = atome_id
    atome
  end

  def audio_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  audio()
  end
end