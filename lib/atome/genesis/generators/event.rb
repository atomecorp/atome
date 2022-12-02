# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:touch)
generator.build_particle(:play)
generator.build_particle(:time)
generator.build_particle(:pause)
generator.build_particle(:on)
generator.build_particle(:fullscreen)
generator.build_particle(:mute)
# TODO : add the at event to ny particle : (width, left, ...) maybe use monitor particle
generator.build_particle(:at)
generator.build_particle(:drag)
generator.build_sanitizer(:drag) do |params|
  params = { move: true } if params == true
  params
end
generator.build_particle(:sort) do |_value, sort_proc|
  @sort_proc = sort_proc
end
