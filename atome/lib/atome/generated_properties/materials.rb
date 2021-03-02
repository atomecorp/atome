module Properties
  def color(value = nil, &proc)
    if value.nil? && !proc
      @color&.read
    else
      value = properties_common(value, &proc)
      @color = atomise(:color,value)
      color_html(@color)
    end
  end 
 def color=(value, &proc)
  color(value, &proc)
 end

  def opacity(value = nil, &proc)
    if value.nil? && !proc
      @opacity&.read
    else
      value = properties_common(value, &proc)
      @opacity = atomise(:opacity,value)
      opacity_html(@opacity)
    end
  end 
 def opacity=(value, &proc)
  opacity(value, &proc)
 end

  def border(value = nil, &proc)
    if value.nil? && !proc
      @border&.read
    else
      value = properties_common(value, &proc)
      @border = atomise(:border,value)
      border_html(@border)
    end
  end 
 def border=(value, &proc)
  border(value, &proc)
 end

  def overflow(value = nil, &proc)
    if value.nil? && !proc
      @overflow&.read
    else
      value = properties_common(value, &proc)
      @overflow = atomise(:overflow,value)
      overflow_html(@overflow)
    end
  end 
 def overflow=(value, &proc)
  overflow(value, &proc)
 end

end
