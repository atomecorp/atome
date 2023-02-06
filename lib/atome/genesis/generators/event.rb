# frozen_string_literal: true



new({particle: :touch , type: :hash, store: false })
new({ post: :touch }) do |params, user_bloc|
  @touch = {} if @touch == nil
  @touch[params] = user_bloc
  # as store for touch is set to false we have to manually save the instance variable
  store_value(:touch)
end

new({particle: :play }) do
  @atome[:pause] = :false
end
new({particle: :time })
new({particle: :pause }) do
  @atome[:play] = :false
end
new({particle: :on })
new({particle: :fullscreen })
new({particle: :mute })
new({particle: :drag })
new({ sanitizer: :drag }) do |params|
  params = { move: true } if params == true
  params
end
new({particle: :sort }) do |_value, sort_proc|
  @sort_proc = sort_proc
end
new({particle: :targets })
new({particle: :start })
new({pre: :start }) do |_value, user_proc|
  @animation_start_proc = user_proc
end
new({particle: :stop })
new({pre: :stop })  do |_value, user_proc|
  @animation_stop_proc = user_proc
end
new({particle: :begin })
new({particle: :end })
new({particle: :duration })
new({particle: :mass })
new({particle: :damping })
new({particle: :stiffness })
new({particle: :velocity })
new({particle: :repeat })
new({particle: :ease })
new({particle: :unbind })
new({particle: :over })


# generator = Genesis.generator
#
# # touch
# generator.build_particle(:touch)
# # video
# generator.build_particle(:play) do
#   @atome[:pause] = :false
# end
# generator.build_particle(:time)
# generator.build_particle(:pause) do
#   @atome[:play] = :false
# end
# generator.build_particle(:on)
# generator.build_particle(:fullscreen)
# generator.build_particle(:mute)
# # TODO : add the at event to ny particle : (width, left, ...) maybe use monitor particle
# # generator.build_particle(:at)
# # drag
# generator.build_particle(:drag)
# generator.build_sanitizer(:drag) do |params|
#   params = { move: true } if params == true
#   params
# end
# # sort
# generator.build_particle(:sort) do |_value, sort_proc|
#   @sort_proc = sort_proc
# end
# # animation
# generator.build_particle(:targets)
# generator.build_particle(:start)
# generator.build_option(:pre_render_start) do |_value, user_proc|
#   @animation_start_proc = user_proc
# end
# generator.build_particle(:stop)
# generator.build_option(:pre_render_stop) do |_value, user_proc|
#   @animation_stop_proc = user_proc
# end
# generator.build_particle(:begin)
# generator.build_particle(:end)
# generator.build_particle(:duration)
# generator.build_particle(:mass)
# generator.build_particle(:damping)
# generator.build_particle(:stiffness)
# generator.build_particle(:velocity)
# generator.build_particle(:repeat)
# generator.build_particle(:ease)
# generator.build_particle(:unbind)
# generator.build_particle(:over)
