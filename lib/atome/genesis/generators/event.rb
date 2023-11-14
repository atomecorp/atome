# frozen_string_literal: true

new({ particle: :touch, type: :hash, store: false })
new({ sanitizer: :touch }) do |params, user_bloc|
  # TODO: factorise code below
  @touch ||= {}
  @touch_code ||= {}
  option = true
  params = if params.instance_of? Hash
             @touch_code[params.keys[0]] = user_bloc
             option = params[params.keys[0]]
             params.keys[0]
           else
             case params
             when true
               @touch_code[:tap] = user_bloc
               :tap
             when :touch
               @touch_code[:tap] = user_bloc
               :tap
             when :down
               @touch_code[:down] = user_bloc
               :down
             when :up
               @touch_code[:up] = user_bloc
               :up
             when :long
               @touch_code[:long] = user_bloc
               :long
             when :double
               @touch_code[:double] = user_bloc
               :double
             when :remove
               params
             when false
               @touch_code[:remove] = user_bloc
               :remove
             else
               @touch_code[:tap] = user_bloc
               :tap
             end
           end
  @touch[params] = option
  params

end
new({ particle: :play, store: false })
new({ sanitizer: :play }) do |params, user_bloc|
  @play ||= {}
  @play_code ||= {}
  option = true
  params = if params.instance_of? Hash
             @play_code[params.keys[0]] = user_bloc
             option = params[params.keys[0]]
             params.keys[0]
           else
             case params
             when true
               @play_code[:play] = user_bloc
               :play
             when :stop
               @play_code[:stop] = user_bloc
               :stop
             when :play
               @play_code[:play] = user_bloc
               :play
             when :pause
               @play_code[:pause] = user_bloc
               :pause
             else
               @play_code[:play] = user_bloc
               option = params
               :play
             end

           end
  @play[params] = option

  params
end

new({ particle: :pause })
new({ particle: :time })
new({ particle: :on }) do |params|
  params = { min: { width: 10, height: 10 }, max: { width: 2000, height: 2000 } } unless params.instance_of? Hash
  params
end
new({ particle: :fullscreen })
new({ particle: :mute })
new({ particle: :drag, store: false })
new({ sanitizer: :drag }) do |params, user_bloc|
  @drag ||= {}
  @drag_code ||= {}
  option = true
  params = if params.instance_of? Hash
             @drag_code[params.keys[0]] = user_bloc
             option = params[params.keys[0]]
             params.keys[0]
           else
             case params
             when true
               @drag_code[:move] = user_bloc
               :move
             when :move
               @drag_code[:move] = user_bloc
               :move
             when :drag
               @drag_code[:move] = user_bloc
               :move
             when :clone
               @drag_code[:clone] = user_bloc
               :clone
             when :start
               @drag_code[:start] = user_bloc
               :start
             when :stop
               @drag_code[:end] = user_bloc
               :end
             when :end
               @drag_code[:end] = user_bloc
               :end
             when :locked
               @drag_code[:locked] = user_bloc
               :locked
             when false
               @drag_code[:remove] = user_bloc
               :remove
             else
               @drag_code[:move] = user_bloc
               :move
             end

           end
  @drag[params] = option
  params
end
new({ particle: :drop, store: false })
new({ sanitizer: :drop }) do |params, user_bloc|
  @drop ||= {}
  @drop_code ||= {}
  option = true
  params = if params.instance_of? Hash
             @drop_code[params.keys[0]] = user_bloc
             option = params[params.keys[0]]
             params.keys[0]
           else
             case params
             when true
               @drop_code[:dropped] = user_bloc
               :dropped
             when :enter
               @drop_code[:enter] = user_bloc
               :enter
             when :activate
               @drop_code[:activate] = user_bloc
               :activate
             when :deactivate
               @drop_code[:deactivate] = user_bloc
               :deactivate
             when :leave
               @drop_code[:leave] = user_bloc
               :leave
             else
               @drop_code[:dropped] = user_bloc
               :dropped
             end

           end
  @drop[params] = option
  params
end
new({ particle: :over, type: :hash, store: false })
new({ sanitizer: :over }) do |params, user_bloc|

  #  TODO: factorise code below
  @over ||= {}
  @over_code ||= {}
  option = true
  params = if params.instance_of? Hash

             @over_code[params.keys[0]] = user_bloc
             option = params[params.keys[0]]
             params.keys[0]
           else
             case params
             when true
               @over_code[:over] = user_bloc
               :over
             when :over
               @over_code[:over] = user_bloc
               :over
             when :enter
               @over_code[:enter] = user_bloc
               :enter
             when :leave
               @over_code[:leave] = user_bloc
               :leave
               # when false
               #   false
             else
               :over
             end

           end

  case params

  when :remove
    @over_code[option]=''
  else
    # nothing
  end
  @over[params] = option

  params

end
new({ particle: :sort }) do |_value, sort_proc|
  @sort_proc = sort_proc
end
new({ particle: :targets })
new({ particle: :start })
new({ pre: :start }) do |_value, user_proc|
  @animation_start_proc = user_proc
end
new({ particle: :stop })
new({ pre: :stop }) do |_value, user_proc|
  @animation_stop_proc = user_proc
end
new({ particle: :begin })
new({ particle: :end })
new({ particle: :duration })
new({ particle: :mass })
new({ particle: :damping })
new({ particle: :stiffness })
new({ particle: :velocity })
new({ particle: :repeat })
new({ particle: :ease })
new(particle: :keyboard, type: :hash, store: false)
new({ sanitizer: :keyboard }) do |params|
  # # TODO: factorise code below
  @keyboard ||= {}

  params = if params.instance_of? Hash
             params.keys[0]
           else

             case params
             when true
               :keypress
             when :press
               :keypress
             when :down
               :keydown
             when :up
               :keyup
             when :input

               :input
             when :kill
               :kill
             else
               :keypress
             end

           end

  @keyboard[params] = true
  params

end
new({ particle: :resize })
new({ particle: :overflow }) do |params, bloc|
  @overflow_code ||= {}
  instance_variable_get('@overflow_code')[:overflow] = bloc
  params

end

