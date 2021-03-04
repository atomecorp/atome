module Properties
  def content(value = nil, &proc)
    if value.nil? && !proc
      @content&.read
    else
      value = properties_common(value, &proc)
      @content = atomise(:content,value)
      content_html(@content)
    end
  end 
 def content=(value, &proc)
  content(value, &proc)
 end

  def video(value = nil, &proc)
    if value.nil? && !proc
      video_getter_processor(value)
    else
      value = properties_common(value, &proc)
      video_pre_processor(value)
    end
  end 
 def video=(value, &proc)
  video(value, &proc)
 end

  def box(value = nil, &proc)
    if value.nil? && !proc
      box_getter_processor(value)
    else
      value = properties_common(value, &proc)
      box_pre_processor(value)
    end
  end 
 def box=(value, &proc)
  box(value, &proc)
 end

  def circle(value = nil, &proc)
    if value.nil? && !proc
      circle_getter_processor(value)
    else
      value = properties_common(value, &proc)
      circle_pre_processor(value)
    end
  end 
 def circle=(value, &proc)
  circle(value, &proc)
 end

  def text(value = nil, &proc)
    if value.nil? && !proc
      text_getter_processor(value)
    else
      value = properties_common(value, &proc)
      text_pre_processor(value)
    end
  end 
 def text=(value, &proc)
  text(value, &proc)
 end

  def image(value = nil, &proc)
    if value.nil? && !proc
      image_getter_processor(value)
    else
      value = properties_common(value, &proc)
      image_pre_processor(value)
    end
  end 
 def image=(value, &proc)
  image(value, &proc)
 end

  def audio(value = nil, &proc)
    if value.nil? && !proc
      audio_getter_processor(value)
    else
      value = properties_common(value, &proc)
      audio_pre_processor(value)
    end
  end 
 def audio=(value, &proc)
  audio(value, &proc)
 end

  def info(value = nil, &proc)
    if value.nil? && !proc
      @info&.read
    else
      value = properties_common(value, &proc)
      @info = atomise(:info,value)
    end
  end 
 def info=(value, &proc)
  info(value, &proc)
 end

  def example(value = nil, &proc)
    if value.nil? && !proc
      @example&.read
    else
      value = properties_common(value, &proc)
      @example = atomise(:example,value)
    end
  end 
 def example=(value, &proc)
  example(value, &proc)
 end

end
