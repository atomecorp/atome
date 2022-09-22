# frozen_string_literal: true

# require './main'

####### particle below

Genesis.new_particle(:left) do
  # puts "extra particle code executed!!"
end

Genesis.new_particle(:top)
Genesis.new_particle(:type)
Genesis.new_particle(:id)
Genesis.new_particle(:red)
Genesis.new_particle(:green)
Genesis.new_particle(:blue)
Genesis.new_particle(:alpha)
Genesis.new_particle(:diffusion)
Genesis.new_particle(:atomes)
Genesis.new_particle(:width)
Genesis.new_particle(:height)
Genesis.new_particle(:parent)
####### atomes below
Genesis.new_atome(:color) do |params|
  # puts "extra atome code executed!! : #{params}"
end
Genesis.new_atome_helper(:color_render_pre_proc) do
  puts "Color helper pre render set\n"
end
Genesis.new_atome(:child)
Genesis.new_atome(:space)
Genesis.new_atome(:shape) do
  # puts "and now!!! "
end
Genesis.new_atome(:drm) do
  puts "and the drms!!! "
end




