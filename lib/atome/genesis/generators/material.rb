# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:red)
generator.build_particle(:green)
generator.build_particle(:blue)
generator.build_particle(:alpha)
generator.build_particle(:visual)
generator.build_particle(:overflow)
generator.build_particle(:edit)
generator.build_particle(:style)
generator.build_option(:pre_render_style) do |styles_send, _user_proc|
  styles_send.each do |particle_send, value|
    send(particle_send, value)
  end
end
