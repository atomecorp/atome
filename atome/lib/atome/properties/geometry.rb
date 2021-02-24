module GeometriesProperties
  def width=(value)
    @width = Quark.new(value)
    width_html(@width)
  end

  def width
    @width.read
  end

  def height=(value)
    @height = Quark.new(value)
    height_html(@height)
  end

  def height
    @height.read
  end
end