module Properties
  def width(value = nil, &proc)
    if value.nil? && !proc
      @width&.read
    else
      value = properties_common(value, &proc)
      @width = atomise(value)
      width_html(@width)
    end
  end 
 def width=(value, &proc)
  width(value, &proc)
 end

  def height(value = nil, &proc)
    if value.nil? && !proc
      @height&.read
    else
      value = properties_common(value, &proc)
      @height = atomise(value)
      height_html(@height)
    end
  end 
 def height=(value, &proc)
  height(value, &proc)
 end

  def rotation(value = nil, &proc)
    if value.nil? && !proc
      @rotation&.read
    else
      value = properties_common(value, &proc)
      @rotation = atomise(value)
      rotation_html(@rotation)
    end
  end 
 def rotation=(value, &proc)
  rotation(value, &proc)
 end

end
