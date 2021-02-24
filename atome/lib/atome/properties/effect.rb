module EffectsProperties
  def blur=(value)
    @blur = Quark.new(value)
    blur_html(@blur)
  end

  def blur
    @blur
  end
end