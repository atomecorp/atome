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

