# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:red) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
generator.build_particle(:green) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
generator.build_particle(:blue) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
generator.build_particle(:alpha) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
generator.build_particle(:diffusion) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
generator.build_particle(:visual)
generator.build_particle(:overflow)
generator.build_particle(:edit)
generator.build_particle(:style)
generator.build_option(:pre_render_style) do |styles_send, _user_proc|
  styles_send.each do |particle_send, value|
    send(particle_send, value)
  end
end
generator.build_particle(:hide)

generator.build_particle(:remove) do |particle_to_remove|
  case particle_to_remove
  when :color
    send(particle_to_remove, :black)
  when :shadow
    # TODO : code to write
    puts 'code to write'
  else
    send(particle_to_remove, 0)
  end
end
