module SpatialsProperties
  def x=(value)
    @x = atomise(value)
    x_html(@x)
  end

  def x
    @x.read
  end

  def xx=(value)
    @xx = atomise(value)
    xx_html(@xx)
  end

  def xx
    @xx.read
  end

  def y=(value)
    @y = atomise(value)
    y_html(@y)
  end

  def y
    @y.read
  end

  def yy=(value)
    @yy = atomise(value)
    yy_html(@yy)
  end

  def yy
    @yy.read
  end

  def z=(value)
    @z = atomise(value)
    z_html(@z)
  end

  def z
    @z.read
  end
end