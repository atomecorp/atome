module MediasProperties
  def content=(value)
    @content = atomise(value)
    content_html(@content)
  end

  def content
  @content&.read
  end

  def box
    alert "return box"
  end

  def box=(value)
    box_processor(value)
  end

  def circle
    alert "return circle"
  end

  def circle=(value)
    circle_processor(value)
  end

  def text
    alert "return text"
  end

  def text=(value)
    text_processor(value)
  end

  def image
    alert "return image"
  end

  def image=(value)
    image_processor(value)
  end

  def video
    alert "return video"
  end

  def video=(value)
    video_processor(value)
  end

  def audio
    alert "return audio"
  end

  def audio=(value)
    audio_processor(value)
  end
end