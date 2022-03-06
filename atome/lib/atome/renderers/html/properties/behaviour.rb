def params_conversion params
  alert  "msg from behaviour/params_conversion:  #{params}"
  params
end

def play_helper params
  # alert "play_helper #{params.class}"
  animations=params.delete(:animations)
  animations.each do |animation|
    if animation[:id] == :video
      js_play(animation,params, atome_id)
    else
      params=params_conversion params
      js_anime(animation,params, atome_id)
    end
  end
end

def play_html values
  # alert "play_html #{values}"
  case values
  when ->(h) { h[:options] == true }
    # in this we play all found animations in animation property
    play_helper(values.merge({ play: "self", animations: animation, at: 0 }))
    # in this we play all found animations in animation property
    # play_helper({ play: "self", animations: animation, at: 0 })
  when ->(h) { h[:options] == 'pause' }
    # in this we pause all found animations in animation property
    play_helper(values.merge({ pause: "self", animations: animation, at: 0 }))
  when ->(h) { h[:options] == 'stop' }
    # in this we stop all found animations in animation property
    play_helper(values.merge({ stop: "self", animations: animation, at: 0 }))
  when ->(h) { h[:value] }
    # in this we play all found animations in animation property at the value passed
    play_helper(values.merge({ play: "self", animations: animation, at: values[:value] }))
  when ->(h) { h[:at] }
    # in this we play all found animations in animation property at the value in values[:at]
    play_helper(values.merge({ play: "self", animations: animation, at: values[:at] }))
  when ->(h) { h[:options] }
    # in this we assume the user want to play the animation found in the options hash
    anim_requested = values[:options]
    if animation.instance_of? Array
      animation.each do |anim_found|
        if anim_found[:id] == anim_requested
          anim_found = anim_found[:id]
          play_helper(values.merge({ play: "self", animations: [{ id: anim_found }], at: 0 }))
        end
      end
    else
      if animation[:id] == anim_requested
        anim_found = animation[:id]
        play_helper(values.merge({ play: "self", animations: [{ id: anim_found }], at: 0 }))
      end

    end

    # play_helper({ play: self, animations: [animation[values[:options]]], at: 0 })
  else
    # alert values
    # play_helper (values)
  end
  # alert self.animation
  # js_play(values)
end