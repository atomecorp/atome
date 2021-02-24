module SpatialsProperties
  def x=(value)
    @x = Quark.new(value)
    x_html(@x)
  end

  def x
    @x.read
  end

  def xx=(value)
    @xx = Quark.new(value)
    xx_html(@xx)
  end

  def xx
    @xx.read
  end

  def y=(value)
    @y = Quark.new(value)
    y_html(@y)
  end

  def y
    @y.read
  end

  def yy=(value)
    @yy = Quark.new(value)
    yy_html(@yy)
  end

  def yy
    @yy.read
  end

  def z=(value)
    @z = Quark.new(value)
    z_html(@z)
  end

  def z
    @z.read
  end
end