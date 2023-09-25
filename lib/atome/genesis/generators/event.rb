# frozen_string_literal: true

new({ particle: :touch, type: :hash, store: false })

new({ post: :touch }) do |params, user_bloc|
  @touch = {} if @touch == nil
  @touch[params] = user_bloc
  # as store for touch is set to false we have to manually save the instance variable
  store_value(:touch)
end

new({ particle: :play }) do
  @atome[:pause] = :false
end
new({ particle: :time })
new({ particle: :pause }) do
  @atome[:play] = :false
end
new({ particle: :on })
new({ particle: :fullscreen })
new({ particle: :mute })
new({ particle: :drag, store: false })

new({ sanitizer: :drag }) do |params, proc|
  params = { move: true } if params == true
  params = { end: proc } if params == :end
  params = { start: proc } if params == :start
  params
end

new({ post: :drag }) do |params|

  @drag = {} if @drag == nil
  # @drag[params] = user_bloc
  params.each do |k, v|
    @drag[k] = v
  end
  # as store for touch is set to false we have to manually save the instance variable
  store_value(:drag)
end

new({ particle: :drop })

new({ sanitizer: :drop }) do |params|
  params = { action: true } if params == true
  params
end

new({ particle: :over, type: :hash, store: false })

new({ post: :over }) do |params, user_bloc|
  @over = {} if @over == nil
  @over[params] = user_bloc
  # as store for touch is set to false we have to manually save the instance variable
  store_value(:over)
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
new({ particle: :unbind })

