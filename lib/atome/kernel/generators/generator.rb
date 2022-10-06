# frozen_string_literal: true

# generators
Genesis.atome_creator(:shape) do
  # puts "and now!!! "
end
Genesis.atome_creator(:shadow)
# Genesis.atome_creator(:additional)
Genesis.atome_creator(:content)
Genesis.atome_creator(:color) do |params|
  # puts "extra color  code executed!! : #{params}"
end

Genesis.atome_creator_option(:color_pre_save_proc) do
  # puts "optional color_pre_save_proc\n"
end

Genesis.atome_creator_option(:color_post_save_proc) do
  # puts "optional color_post_save_proc\n"
end

Genesis.atome_creator_option(:color_pre_render_proc) do
  # puts "optional color_pre_render_proc\n"
end

Genesis.atome_creator_option(:color_post_render_proc) do
  # puts "optional color_post_render_proc\n"
end

Genesis.atome_creator_option(:color_getter_pre_proc) do
  # puts "optional color_getter_pre_proc\n"
end

Genesis.particle_creator(:id) do
  puts  "this is a specific dummy addon for this method!"
end
Genesis.particle_creator(:left)
Genesis.particle_creator(:right)
Genesis.particle_creator(:top)
Genesis.particle_creator(:bottom)
Genesis.particle_creator(:width)
Genesis.particle_creator(:height)
Genesis.particle_creator(:red)
Genesis.particle_creator(:green)
Genesis.particle_creator(:blue)
Genesis.particle_creator(:alpha)
Genesis.particle_creator(:type)
Genesis.particle_creator(:render)
puts '!!!!!!!!!!!!!!  no render for render method !!!!!!!!!!!!!!'
Genesis.particle_creator(:date)
Genesis.particle_creator(:location)
