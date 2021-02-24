module GeometriesProperties
  def width=(value)
    @width = atomise(value)
    width_html(@width)
  end

  def width
    @width.read
  end

  def height=(value)
    @height = atomise(value)
    height_html(@height)
  end

  def height
    @height.read
  end
end