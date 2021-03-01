module Properties
  def contour(value = nil, &proc)
    if value.nil? && !proc
      @contour&.read
    else
      value = properties_common(value, &proc)
      @contour = atomise(value)
      contour_html(@contour)
    end
  end 
 def contour=(value, &proc)
  contour(value, &proc)
 end

  def reverb(value = nil, &proc)
    if value.nil? && !proc
      @reverb&.read
    else
      value = properties_common(value, &proc)
      @reverb = atomise(value)
      reverb_html(@reverb)
    end
  end 
 def reverb=(value, &proc)
  reverb(value, &proc)
 end

  def delay(value = nil, &proc)
    if value.nil? && !proc
      @delay&.read
    else
      value = properties_common(value, &proc)
      @delay = atomise(value)
      delay_html(@delay)
    end
  end 
 def delay=(value, &proc)
  delay(value, &proc)
 end

  def saturation(value = nil, &proc)
    if value.nil? && !proc
      @saturation&.read
    else
      value = properties_common(value, &proc)
      @saturation = atomise(value)
      saturation_html(@saturation)
    end
  end 
 def saturation=(value, &proc)
  saturation(value, &proc)
 end

end
