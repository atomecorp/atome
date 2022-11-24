# frozen_string_literal: true

generator = Genesis.generator
# create particles
generator.build_particle(:left) do |_params, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end

generator.build_particle(:right)
generator.build_particle(:top)
generator.build_particle(:bottom)
generator.build_particle(:rotate)
generator.build_particle(:direction)
