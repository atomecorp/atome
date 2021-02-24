module EffectsProperties
  def blur=(value)
    @blur = atomise(value)
    blur_html(@blur)
  end

  def blur
    @blur
  end

  def smooth=(value)
    @smooth = atomise(value)
    smooth_html(@smooth)
  end

  def smooth
    @smooth
  end
end