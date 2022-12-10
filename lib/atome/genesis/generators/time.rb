# frozen_string_literal: true

generator = Genesis.generator
# create particles
generator.build_particle(:markers, :hash)

generator.build_option(:pre_render_markers) do |markers, _user_proc|
  markers.each do |marker, value|
    atome[:markers][marker] = value
  end
end
