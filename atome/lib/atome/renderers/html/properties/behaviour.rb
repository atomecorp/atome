def play_helper params
  # animations_to_play=params[:animations]
  puts "msg form behaviour.rb play_helper : #{params[:animations]} atome_id : #{atome_id}"

  params[:animations].each do |animation|
    if animation[:id]==:video
      js_play(animation, atome_id)
    else
      js_anime(animation, atome_id)
    end
  end
  # js_play(values)
  # animations_to_play.each do |anim_found|
  #   # puts " #{targeted_atome} #{anim_found}"
  # end
end

def play_html values
  alert values
  # alert "behaviours play_html rewrite the whole function to simplify case video/anim and pass proc +options +anims#{values}"
  case values
  when ->(h) { h[:options] == true }
    # in this we play all found animations in animation property
    play_helper({ play: "self", animations: animation, at: 0 })
    # alert ({ play: atome_id })
  # when ->(h) { h[:options] == 'play' }
    # in this we play all found animations in animation property
    # play_helper({ play: "self", animations: animation, at: 0 })
  when ->(h) { h[:options] == 'pause' }
    # in this we pause all found animations in animation property
    play_helper({ pause: "self", animations: animation, at: 0 })
  when ->(h) { h[:options] == 'stop' }
    # in this we stop all found animations in animation property
    play_helper({ stop: "self", animations: animation, at: 0 })
  when ->(h) { h[:value] }
    # in this we play all found animations in animation property at the value passed
    play_helper({ play: "self", animations: animation, at: values[:value] })
  when ->(h) { h[:at] }
    # in this we play all found animations in animation property at the value in values[:at]
    play_helper({ play: "self", animations: animation, at: values[:at] })
  when ->(h) { h[:options] }
    # in this we assume the user want to play the animation found in the options hash
    anim_requested = values[:options]
    if animation.instance_of? Array
      animation.each do |anim_found|
        #   alert "values : #{values}, #{anim_found} #{anim_found.length}"
        if anim_found[:id] == anim_requested
          anim_found = anim_found[:id]
          play_helper({ play: "self", animations: [{ id: anim_found }], at: 0 })
        end
      end
    else
      if animation[:id] == anim_requested
        anim_found = animation[:id]
        play_helper({ play: "self", animations: [{ id: anim_found }], at: 0 })
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