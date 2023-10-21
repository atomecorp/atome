# frozen_string_literal: true

new({ particle: :touch, type: :hash, store: false })

new({ sanitizer: :touch }) do |params, _user_bloc|
  # TODO: factorise code below
  @touch ||= {}
  params = if params.instance_of? Hash
             params.keys[0]
           else
             case params
             when true
               :tap
             when :touch
               :tap
             when :down
               :down
             when :up
               :up
             when :long
               :long
             when :double
               :double
             when false
               false
             else
               :tap
             end

           end
  @touch[params] = true

  store_value(:touch)
  params

end

new({ particle: :play })
new({ particle: :pause })

# new({ particle: :play }) do
#   @atome[:pause] = :false
# end
new({ particle: :time })
# new({ particle: :pause }) do
#   @atome[:play] = :false
# end
new({ particle: :on })
new({ particle: :fullscreen })
new({ particle: :mute })

new({ particle: :drag, store: false })
new({ sanitizer: :drag }) do |params, _proc|
  @drag ||= {}
  params = if params.instance_of? Hash
             params.keys[0]
           else
             case params
             when true
               :move
             when :move
               :move
             when :drag
               :move
             when :clone
               :clone
             when :start
               :start
             when :stop
               :end
             when :end
               :end
             when :lock
               :lock
             when false
               false
             else
               :tap
             end

           end
  @drag[params] = true
  store_value(:drag)
  params
end

new({ particle: :drop, store: false })
new({ sanitizer: :drop }) do |params|
  # params = { action: true } if params == true

  @drop ||= {}
  params = if params.instance_of? Hash
             params.keys[0]
           else
             case params
             when true
               :true
             when :enter
               :enter
             when :activate
               :activate
             when :deactivate
               :deactivate
             when :leave
               :leave
             else
               :true
             end

           end
  @drop[params] = true

  store_value(:drop)
  params

end

new({ particle: :over, type: :hash, store: false })
new({ sanitizer: :over }) do |params|
  # # TODO: factorise code below

  @over ||= {}
  params = if params.instance_of? Hash
             params.keys[0]
           else
             case params
             when true
               :over
             when :over
               :over
             when :enter
               :enter
             when :leave
               :leave
             when false
               false
             else
               :over
             end

           end
  @over[params] = true

  store_value(:over)
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
  store_value(:keyboard)
  params

end

new({ particle: :resize })

