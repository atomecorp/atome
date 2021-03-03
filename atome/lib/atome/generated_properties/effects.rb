module Properties
  def blur(value = nil, &proc)
    if value.nil? && !proc
      @blur&.read
    else
      value = properties_common(value, &proc)
      @blur = atomise(:blur,value)
      blur_html(@blur)
    end
  end 
 def blur=(value, &proc)
  blur(value, &proc)
 end

  def shadow(value = nil, &proc)
    if value.nil? && !proc
      @shadow&.read
    else
      value = properties_common(value, &proc)
      @shadow = atomise(:shadow,value)
      shadow_html(@shadow)
    end
  end 
 def shadow=(value, &proc)
  shadow(value, &proc)
 end

  def smooth(value = nil, &proc)
    if value.nil? && !proc
      @smooth&.read
    else
      value = properties_common(value, &proc)
      @smooth = atomise(:smooth,value)
      smooth_html(@smooth)
    end
  end 
 def smooth=(value, &proc)
  smooth(value, &proc)
 end

end
