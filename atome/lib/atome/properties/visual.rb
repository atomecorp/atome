module VisualsProperties
  def color=(value = nil)
    color_html(value)
    @color = value
  end

  def color
    @color
  end

  def border=(value = nil)
    border_html(value)
    @border = value
  end

  def border
    @border
  end

  def overflow=(value = nil)
    overflow_html(value)
    @overflow = value
  end

  def overflow
    @overflow
  end

  def opacity=(value = nil)
    opacity_html(value)
    @opacity = value
  end

  def opacity
    @opacity
  end

  def shadow=(value = nil)
    shadow_html(value)
    @shadow = value
  end

  def shadow
    @shadow
  end
end
