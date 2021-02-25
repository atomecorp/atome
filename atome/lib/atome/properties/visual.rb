module VisualsProperties
  def color=(value)
    @color = atomise(value)
    color_html(@color)
  end

  def color
    @color&.read
  end

  def border=(value)
    @border = atomise(value)
    border_html(@border)
  end

  def border
    @border&.read
  end

  def overflow=(value)
    @overflow = atomise(value)
    overflow_html(@overflow)
  end

  def overflow
    @overflow&.read
  end

  def opacity=(value)
    @opacity = atomise(value)
    opacity_html(@opacity)
  end

  def opacity
    @opacity&.read
  end

  def shadow=(value)
    @shadow = atomise(value)
    shadow_html(@shadow)
  end

  def shadow
    @shadow&.read
  end
end
