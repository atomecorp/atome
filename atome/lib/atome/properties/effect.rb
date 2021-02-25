module EffectsProperties
  def blur=(value)
    @blur = atomise(value)
    blur_html(@blur)
  end

  def blur
    @blur&.read
  end

  def smooth=(value)
    @smooth = atomise(value)
    smooth_html(@smooth)
  end

  def smooth
    @smooth&.read
  end
end