module Properties
  def touch(value = nil, &proc)
    if value.nil? && !proc
      @touch&.read
    else
      value = properties_common(value, &proc)
      @touch = atomise(:touch,value)
      touch_html(@touch)
      self
    end
  end 
 def touch=(value, &proc)
  touch(value, &proc)
 end

  def drag(value = nil, &proc)
    if value.nil? && !proc
      @drag&.read
    else
      value = properties_common(value, &proc)
      @drag = atomise(:drag,value)
      drag_html(@drag)
      self
    end
  end 
 def drag=(value, &proc)
  drag(value, &proc)
 end

  def over(value = nil, &proc)
    if value.nil? && !proc
      @over&.read
    else
      value = properties_common(value, &proc)
      @over = atomise(:over,value)
      over_html(@over)
      self
    end
  end 
 def over=(value, &proc)
  over(value, &proc)
 end

end
