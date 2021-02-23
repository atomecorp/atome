module GeometriesProperties
  def width=(value = nil)
    width_html(value)
    @width = value
  end

  def width
    @width
  end

  def height=(value = nil)
    height_html(value)
    @height = value
  end

  def height
    @height
  end
end