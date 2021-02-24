module VisualsProperties
  def color=(value)
    @color = Quark.new(value)
    color_html(@color)
  end

  def color
    @color.read
  end

  def border=(value)
    @border = Quark.new(value)
    border_html(@border)
  end

  def border
    @border
  end

  def overflow=(value)
    @overflow = Quark.new(value)
    overflow_html(@overflow)
  end

  def overflow
    @overflow.read
  end

  def opacity=(value)
    @opacity = Quark.new(value)
    opacity_html(@opacity)
  end

  def opacity
    @opacity.read
  end

  def shadow=(value)
    @shadow = Quark.new(value)
    shadow_html(@shadow)
  end

  def shadow
    @shadow.read
  end
end
