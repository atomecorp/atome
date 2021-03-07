module Properties
  def width(value = nil, &proc)
    if value.nil? && !proc
      @width&.read
    else
      value = properties_common(value, &proc)
      @width = atomise(:width,value)
      width_html(@width)
      self
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
      @height = atomise(:height,value)
      height_html(@height)
      self
    end
  end 
 def height=(value, &proc)
  height(value, &proc)
 end

  def size(value = nil, &proc)
    if value.nil? && !proc
      @size&.read
    else
      value = properties_common(value, &proc)
      @size = atomise(:size,value)
      size_processor(value)
      size_html(@size)
      self
    end
  end 
 def size=(value, &proc)
  size(value, &proc)
 end

  def rotation(value = nil, &proc)
    if value.nil? && !proc
      @rotation&.read
    else
      value = properties_common(value, &proc)
      @rotation = atomise(:rotation,value)
      rotation_html(@rotation)
      self
    end
  end 
 def rotation=(value, &proc)
  rotation(value, &proc)
 end

end
