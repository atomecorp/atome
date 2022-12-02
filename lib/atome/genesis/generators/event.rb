# frozen_string_literal: true

generator = Genesis.generator

# touch
generator.build_particle(:touch)
# video
generator.build_particle(:play)
generator.build_particle(:time)
generator.build_particle(:pause)
generator.build_particle(:on)
generator.build_particle(:fullscreen)
generator.build_particle(:mute)
# TODO : add the at event to ny particle : (width, left, ...) maybe use monitor particle
generator.build_particle(:at)
# drag
generator.build_particle(:drag)
generator.build_sanitizer(:drag) do |params|
  params = { move: true } if params == true
  params
end
# sort
generator.build_particle(:sort) do |_value, sort_proc|
  @sort_proc = sort_proc
end

# animation
generator.build_particle(:targets)
generator.build_particle(:start)
generator.build_option(:pre_render_start) do |_value, user_proc|
  @animation_start_proc = user_proc
end
generator.build_particle(:stop)
generator.build_option(:pre_render_stop) do |_value, user_proc|
  @animation_stop_proc = user_proc
end
generator.build_particle(:begin)
generator.build_particle(:end)
generator.build_particle(:duration)
generator.build_particle(:mass)
generator.build_particle(:damping)
generator.build_particle(:stiffness)
generator.build_particle(:velocity)
generator.build_particle(:repeat)
generator.build_particle(:ease)
