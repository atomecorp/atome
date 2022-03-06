module JSUtils
  def js_play(animation,params, atome_id)
    unless params[:target]
      params[:target] = atome_id
    end
    alert "JSUtils -\nparams:n#{params},\n animation:\n#{animation},\ntype: #{self.type}"
    case self.type
    when :audio
      `videoHelper.playAudio(#{animation[:target]},#{animation[:options]},#{params})`
    when :video
      `videoHelper.playVideo(#{animation[:target]},#{animation[:options]},#{params})`
    else
      `videoHelper.playVideo(#{animation[:target]},#{animation[:options]},#{params})`
    end

  end

  def js_anime(animation,params, atome_id)
    # the function below is in ww/public.js/atome_libraries/animator_helper.js
    $$.animator.animation(animation,params, atome_id)
  end

  def self.js_play_callback(timer, proc)
    proc.call(timer) if proc.is_a?(Proc)
  end

  def self.js_play_set_instance_variable(atome_id, timer, status)
    grab(atome_id).instance_variable_set("@play", { play: timer, status: status })
  end

  # def self.animator(params)
  #   # the function below is in ww/public.js/atome_libraries/animator_helper.js
  #   $$.animator.animation(params)
  # end
end