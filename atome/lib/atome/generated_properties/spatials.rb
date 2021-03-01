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

  def size(value = nil, &proc)
    if value.nil? && !proc
      @size&.read
    else
      value = properties_common(value, &proc)
      @size = atomise(value)
      size_html(@size)
    end
  end 
 def size=(value, &proc)
  size(value, &proc)
 end

  def x(value = nil, &proc)
    if value.nil? && !proc
      @x&.read
    else
      value = properties_common(value, &proc)
      @x = atomise(value)
      x_html(@x)
    end
  end 
 def x=(value, &proc)
  x(value, &proc)
 end

  def xx(value = nil, &proc)
    if value.nil? && !proc
      @xx&.read
    else
      value = properties_common(value, &proc)
      @xx = atomise(value)
      xx_html(@xx)
    end
  end 
 def xx=(value, &proc)
  xx(value, &proc)
 end

  def y(value = nil, &proc)
    if value.nil? && !proc
      @y&.read
    else
      value = properties_common(value, &proc)
      @y = atomise(value)
      y_html(@y)
    end
  end 
 def y=(value, &proc)
  y(value, &proc)
 end

  def yy(value = nil, &proc)
    if value.nil? && !proc
      @yy&.read
    else
      value = properties_common(value, &proc)
      @yy = atomise(value)
      yy_html(@yy)
    end
  end 
 def yy=(value, &proc)
  yy(value, &proc)
 end

  def z(value = nil, &proc)
    if value.nil? && !proc
      @z&.read
    else
      value = properties_common(value, &proc)
      @z = atomise(value)
      z_html(@z)
    end
  end 
 def z=(value, &proc)
  z(value, &proc)
 end

  def center(value = nil, &proc)
    if value.nil? && !proc
      @center&.read
    else
      value = properties_common(value, &proc)
      @center = atomise(value)
      center_html(@center)
    end
  end 
 def center=(value, &proc)
  center(value, &proc)
 end

end
