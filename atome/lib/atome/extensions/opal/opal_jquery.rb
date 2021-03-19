class Element
  def create(parent)
    `atome.jsCreateVideo(#{parent})`
  end
end

class Event
  def key
    `String.fromCharCode(#@native.keyCode)`
  end

  def key_char
    self.key
  end

  def touch_x(touch_nb = 0)
    `#@native.originalEvent.touches[#{touch_nb}].pageX`
  end

  def touch_y(touch_nb = 0)
    `#@native.originalEvent.touches[#{touch_nb}].pageY`
  end

end


module Events
  #def self.update_values params
  #  @x = params[0]
  #  @y = params[1]
  #  # we update current_atome position
  #  return self
  #end

  def playing(proc, evt)
    @time = evt
    #evt = Events.update_values(evt)
    proc.call(evt) if proc.is_a?(Proc)
  end
end