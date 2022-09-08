class Element
  def position(params)
    atome_id = "##{params.delete(:atome_id)}"
    `$(#{atome_id}).position(#{params.to_n})`
  end

  def create_video(parent)
    `videoHelper.addVideoPlayer(#{parent}, false)`
  end

  def create_audio(parent)
    `videoHelper.addAudioPlayer(#{parent}, false)`
  end

  # def off(value)
  #   ` $(window).off(#{value})`
  # end

  def remove_text(atome_id)
    `
    let isTextNode = (_, el) => el.nodeType === Node.TEXT_NODE;
    $("#"+#{atome_id}).contents().filter(isTextNode).remove();
    `
  end
end

class Event
  def key
    `String.fromCharCode(#{@native}.keyCode)`
  end

  def key_char
    self.key
  end


  # def js
  #   @native
  # end
  #
  # def native
  #   @native
  # end

  def touch_x(touch_nb = 0)
    `#{@native}.originalEvent.touches[#{touch_nb}].pageX`
  end

  def touch_y(touch_nb = 0)
    `#{@native}.originalEvent.touches[#{touch_nb}].pageY`
  end

  def offset_x=(value)
    @offset_x = value
  end

  def offset_x
    @offset_x
  end

  def offset_y=(value)
    @offset_y = value
  end

  def offset_y
    @offset_y
  end

  def start=(value)
    @drag_star = value
  end

  def start
    @drag_star
  end

  def stop=(value)
    @drag_stop = value
  end

  def stop
    @drag_stop
    #fixme this method collide with opal jquery event.rb
    `#@native.stopPropagation()`
  end

  # def stop_propagation(evt)
  #   alert "stop propagation opal_jquery"
  #   `#@native.stopPropagation()`
  # end

end

module Events
  def self.playing(proc, evt)
    @time = evt
    #evt = Events.update_values(evt)
    proc.call(evt) if proc.is_a?(Proc)
  end
end