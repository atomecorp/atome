# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:render)
generator.build_particle(:bloc)
generator.build_particle(:broadcast)
generator.build_particle(:additional)
generator.build_particle(:data) do |data|
  # according to the type we send the data to different operator
  type_found = @atome[:type]
  send("data_#{type_found}_processor", data)
end
generator.build_particle(:delete) do
  Universe.delete(@atome[:id])
end
generator.build_particle(:clear)
