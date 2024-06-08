# frozen_string_literal: true

new({ particle: :touch, category: :event, type: :hash, store: false })
new({ sanitizer: :touch }) do |params, user_bloc|
  if params
    # TODO: factorise code below
    @touch ||= {}
    @touch_code ||= {}
    option = true
    params = if params.instance_of? Hash
         user_bloc =params.delete(:code) if params[:code]
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
  else
    @touch = false
    params
  end

end
new({ particle: :play, category: :event, type: :boolean, store: false })
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
new({ particle: :pause, category: :event, type: :boolean })
new({ particle: :time, category: :event, type: :int })
new({ particle: :on, category: :event, type: :boolean, store: false })
new({ sanitizer: :on }) do |params, user_bloc|
  @on ||= {}
  @on_code ||= {}

  option = {}
  params = if params.instance_of? Hash
             @on_code[:view_resize] = user_bloc
             option = params[params.keys[0]]
             :resize
           else
             case params
             when true
               @on_code[:view_resize] = user_bloc
               :resize
             when :remove

               :remove
             else
               @on_code[:view_resize] = user_bloc
               option = params
               :resize
             end
           end
  @on[params] = option
  params
end
new({ particle: :fullscreen, category: :event, type: :boolean })
new({ particle: :mute, category: :event, type: :boolean })
new({ particle: :drag, category: :event, type: :boolean, store: false })
new({ sanitizer: :drag }) do |params, user_bloc|
  @drag ||= {}
  @drag_code ||= {}
  option = true
  params = if params.instance_of? Hash
       user_bloc =params.delete(:code) if params[:code]
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
  if params == :remove
    params = false
  else
    @drag[params] = option
  end

  params
end
new({ particle: :drop, category: :event, type: :boolean, store: false })
new({ sanitizer: :drop }) do |params, user_bloc|
  @drop ||= {}
  @drop_code ||= {}
  option = true
  params = if params.instance_of? Hash
       user_bloc =params.delete(:code) if params[:code]
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
new({ particle: :over, category: :event, type: :hash, store: false })
new({ sanitizer: :over }) do |params, user_bloc|

  #  TODO: factorise code below
  @over ||= {}
  @over_code ||= {}
  option = true
  params = if params.instance_of? Hash
       user_bloc =params.delete(:code) if params[:code]
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

  @over[params] = option
  params

end
# new({ particle: :sort }) do |_value, sort_proc|
#   @sort_proc = sort_proc
# end
new({ particle: :targets, category: :event, type: :string })
new({ particle: :start, category: :event, type: :boolean })
new({ pre: :start }) do |_value, user_proc|
  @animation_start_proc = user_proc
end
new({ particle: :stop, category: :event, type: :boolean })
new({ pre: :stop }) do |_value, user_proc|
  @animation_stop_proc = user_proc
end
new({ particle: :begin, category: :event, type: :time })
new({ particle: :end, category: :event, type: :time })
new({ particle: :duration, category: :event, type: :int })
new({ particle: :mass, category: :event, type: :int })
new({ particle: :damping, category: :event, type: :int })
new({ particle: :stiffness, category: :event, type: :int })
new({ particle: :velocity, category: :event, type: :int })
new({ particle: :repeat, category: :event, type: :boolean })
new({ particle: :ease, category: :event, type: :boolean })
new(particle: :keyboard, category: :event, type: :hash, store: false)
new({ sanitizer: :keyboard }) do |params, user_bloc|
  @keyboard ||= {}
  @keyboard_code ||= {}

  option = {}
  params = if params.instance_of? Hash
             # @keyboard_code[:keyboard] = user_bloc
             # option = params[params.keys[0]]
             # :remove
             user_bloc =params.delete(:code) if params[:code]
             @keyboard_code[params.keys[0]] = user_bloc
             option = params[params.keys[0]]
             params.keys[0]
           else
             case params
             when true
               @keyboard_code[:press] = user_bloc
               :press
             when :down
               @keyboard_code[:down] = user_bloc
               :down
             when :up
               @keyboard_code[:up] = user_bloc
               :up
             when :press
               @keyboard_code[:press] = user_bloc
               :press
             when :remove
               @keyboard_code[:remove] = user_bloc
               :remove
             else
               @keyboard_code[:press] = user_bloc
               option = params
               :press
             end

           end
  @keyboard[params] = option

  params
end
new({ particle: :resize, category: :event, type: :boolean, store: false })
new({ sanitizer: :resize }) do |params, user_bloc|
  @resize ||= {}
  @resize_code ||= {}

  option = { min: { width: 10, height: 10 }, max: { width: 3000, height: 3000 } }
  params = if params.instance_of? Hash
             @resize_code[:resize] = user_bloc
             option = params[params.keys[0]]
             :resize
           else
             case params
             when true
               @resize_code[:resize] = user_bloc
               :resize
             when :remove
               :remove
             else
               @resize_code[:resize] = user_bloc
               option = params
               :resize
             end
           end
  @resize[params] = option

  params
end
new({ particle: :overflow, category: :event, type: :boolean }) do |params, bloc|
  @overflow_code ||= {}
  instance_variable_get('@overflow_code')[:overflow] = bloc
  params

end

class Atome
  def animation_callback(proc_sub_category, value=nil)
    # puts  "#{p◊roc_sub_category}"
    proc_found = @animate_code[proc_sub_category]
    # puts proc_found
    instance_exec(value,&proc_found) if proc_found.is_a?(Proc)
  end
end

new({ particle: :animate, category: :event, type: :hash }) do |params, proc|
  if params.instance_of? Hash
    params = { from: 0, to: 300, duration: 1000 }.merge(params)
  else
    params = { from: 0, to: 300, duration: 1000 }
  end
  # @animate_code["#{params[:particle]}"] = proc
  if params[:end]
    @animate_code["#{params[:end]}_end"] = proc
  else
    @animate_code||= {}
    @animate_code["#{params[:particle]}"] = proc
  end

  params
end

new ({ after: :animate }) do |params|
  html.animate(params) unless params[:end] || params[:start]
end
