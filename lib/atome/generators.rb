# frozen_string_literal: true

@atome = nil
@user_proc = nil
@property = nil
@real_atome = nil

# generator
# TODO : automatise thc creation oll renderer_methods for all renderers

generator = Genesis.generator
# create particles
generator.build_particle(:left) do |_params, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end

generator.build_particle(:right)
generator.build_particle(:top)
generator.build_particle(:bottom)

generator.build_particle(:red)
generator.build_particle(:green)
generator.build_particle(:blue)
generator.build_particle(:alpha)

generator.build_particle(:overflow)

generator.build_particle(:type)
generator.build_particle(:parent)
generator.build_particle(:id)
generator.build_particle(:render)
generator.build_particle(:bloc)
generator.build_particle(:additional)

# create atomes
generator.build_atome(:color) do |_params, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end

generator.build_atome(:video)

generator.build_atome(:shadow)

generator.build_atome(:shape)
generator.build_atome(:text)
generator.build_atome(:image)

# optional methods
