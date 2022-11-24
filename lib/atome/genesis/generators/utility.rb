# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:renderers)
generator.build_particle(:bloc)
generator.build_particle(:broadcast)
generator.build_particle(:additional)
generator.build_particle(:data)
generator.build_particle(:delete) do
  Universe.delete(@atome[:id])
end
generator.build_particle(:clear)
generator.build_particle(:path)
