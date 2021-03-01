module MediasProperties
  def content(value = nil, &proc)
    if value.nil? && !proc
      @content&.read
    else
      value = properties_common(value, &proc)
      @content = atomise(value)
      content_html(@content)
    end
  end 
 def content=(value, &proc)
  content(value, &proc)
 end

  def video(value = nil, &proc)
    if value.nil? && !proc
      video_getter_processor(value)
      @video&.read
    else
      value = properties_common(value, &proc)
       video_processor(value)
    end
  end 
 def video=(value, &proc)
  video(value, &proc)
 end

  def box(value = nil, &proc)
    if value.nil? && !proc
      box_getter_processor(value)
      @box&.read
    else
      value = properties_common(value, &proc)
       box_processor(value)
    end
  end 
 def box=(value, &proc)
  box(value, &proc)
 end

  def circle(value = nil, &proc)
    if value.nil? && !proc
      circle_getter_processor(value)
      @circle&.read
    else
      value = properties_common(value, &proc)
       circle_processor(value)
    end
  end 
 def circle=(value, &proc)
  circle(value, &proc)
 end

  def text(value = nil, &proc)
    if value.nil? && !proc
      text_getter_processor(value)
      @text&.read
    else
      value = properties_common(value, &proc)
       text_processor(value)
    end
  end 
 def text=(value, &proc)
  text(value, &proc)
 end

  def image(value = nil, &proc)
    if value.nil? && !proc
      image_getter_processor(value)
      @image&.read
    else
      value = properties_common(value, &proc)
       image_processor(value)
    end
  end 
 def image=(value, &proc)
  image(value, &proc)
 end

  def audio(value = nil, &proc)
    if value.nil? && !proc
      audio_getter_processor(value)
      @audio&.read
    else
      value = properties_common(value, &proc)
       audio_processor(value)
    end
  end 
 def audio=(value, &proc)
  audio(value, &proc)
 end

end
