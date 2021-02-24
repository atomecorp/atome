module EffectsProperties
  def blur=(value)
    @blur = atomise(value)
    blur_html(@blur)
  end

  def blur
    @blur
  end
end