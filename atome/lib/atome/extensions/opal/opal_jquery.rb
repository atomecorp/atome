class Element
  def create(parent)
    `mediaHelper.addVideoPlayer(#{parent}, false)`
  end

  def position(params)
    atome_id="##{params.delete(:atome_id)}"
        `$(#{atome_id}).position(#{params.to_n})`
  end
end

class Event
  def key
    `String.fromCharCode(#{@native}.keyCode)`
  end

  def key_char
    self.key
  end

  def touch_x(touch_nb = 0)
    `#{@native}.originalEvent.touches[#{touch_nb}].pageX`
  end

  def touch_y(touch_nb = 0)
    `#{@native}.originalEvent.touches[#{touch_nb}].pageY`
  end

end

module Events
  def self.playing(proc, evt)
    @time = evt
    #evt = Events.update_values(evt)
    proc.call(evt) if proc.is_a?(Proc)
  end
end