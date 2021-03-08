module Properties
  def x(value = nil, &proc)
    if value.nil? && !proc
      @x&.read
    else
      value = properties_common(value, &proc)
      @x = atomise(:x,value)
      x_html(@x)
      self
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
      @xx = atomise(:xx,value)
      xx_html(@xx)
      self
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
      @y = atomise(:y,value)
      y_html(@y)
      self
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
      @yy = atomise(:yy,value)
      yy_html(@yy)
      self
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
      @z = atomise(:z,value)
      z_html(@z)
      self
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
      @center = atomise(:center,value)
      center_html(@center)
      self
    end
  end 
 def center=(value, &proc)
  center(value, &proc)
 end

  def rotate(value = nil, &proc)
    if value.nil? && !proc
      @rotate&.read
    else
      value = properties_common(value, &proc)
      @rotate = atomise(:rotate,value)
      rotate_html(@rotate)
      self
    end
  end 
 def rotate=(value, &proc)
  rotate(value, &proc)
 end

end
