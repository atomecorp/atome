module JSUtils
  def js_play(options, proc)
    case self.type
    when :audio
      `videoHelper.playAudio(#{atome_id},#{options},#{proc})`
    when :video
      `videoHelper.playVideo(#{atome_id},#{options},#{proc})`
    else
      `videoHelper.playVideo(#{atome_id},#{options},#{proc})`
    end
  end

  def self.js_play_callback(timer, proc)
    proc.call(timer) if proc.is_a?(Proc)
  end

  def self.js_play_set_instance_variable(atome_id,timer)
    grab(atome_id).instance_variable_set( "@play", timer )
  end
end