
require './atome_v3'

####### particle below

Genesis.new_particle(:left) do
  # puts "extra particle code executed!!"
end


Genesis.new_particle(:top)
Genesis.new_particle(:type)
Genesis.new_particle(:id)
Genesis.new_particle(:red)
Genesis.new_particle(:atomes)

####### atomes below
Genesis.new_atome(:color) do |params|
  # puts "extra atome code executed!! : #{params}"
end
Genesis.new_atome_helper(:color_render_pre_proc) do
  puts "ok\n"*99
end
Genesis.new_atome(:child, :children)

Genesis.new_atome(:shape)
