module JSUtils
  def js_play(params, atome_id)
    unless params[:target]
      params[:target]=atome_id
    end
    # alert params
    case self.type
    when :audio
      `videoHelper.playAudio(#{params[:target]},#{params[:options]},#{proc})`
    when :video
      `videoHelper.playVideo(#{params[:target]},#{params[:options]},#{proc})`
    else
      `videoHelper.playVideo(#{params[:target]},#{params[:options]},#{proc})`
    end

  end

  def js_anime(params, atome_id)
    puts "ready to animate!!!!"
  end

  def self.js_play_callback(timer, proc)
    proc.call(timer) if proc.is_a?(Proc)
  end

  def self.js_play_set_instance_variable(atome_id, timer, status)
    grab(atome_id).instance_variable_set("@play", { play: timer, status: status })
  end
end