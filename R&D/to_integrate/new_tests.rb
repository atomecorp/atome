require './atomic'


# methods generator

Genesis.new_atome(:color) do |params|
  # puts "extra color code executed!! : #{params}"
end
Genesis.new_atome_helper(:color_render_pre_proc) do |value|
  # puts ":======> Color helper pre render set #{value}\n"
end
Genesis.new_atome(:shape)
Genesis.new_atome(:drm)
Genesis.new_atome(:dna)
# tests
Genesis.new_particle(:red) do
  # puts "extra red particle code executed!!"
end
Genesis.new_particle(:green)
Genesis.new_particle(:blue)
Genesis.new_particle(:top)
Genesis.new_atome_helper(:top_render_pre_proc) do |value|
  # puts "top helper pre render set : #{value}\n"
end

# Genesis.new_atome_helper(:y_render_pre_proc) do |params|
#   puts 'atome helper render_pre_proc is executed : '+params
# end

a = {
  id: :my_shapes_container,
  drms: { drm_id: { color: :read }, drm_id2: { red: :all } },
  dnas: { dna_id: { author: :jeezs, date: :a_10_06_33 } },
  shapes: { shape1_id: { width: 33, height: 999 }, shape2_id: { width: 666, height: 333 } },
  colors: { color1_id: { red: 0.3, green: 0.1 }, color22: { red: 0.9, green: 0.39 } }
}


a = {
  id: :my_shapes_container,
  shapes: { shape1_id: { width: 33, height: 999 }, shape2_id: { width: 666, height: 333 } },
  # colors: { color1_id: { red: 0.3, green: 0.1 }, color22: { red: 0.9, green: 0.39 } }
}
# Atome.new()

b = Atome.new(a)
# b = Atome.new
# puts '------ Results ------'

# b.color({red: 10})


# puts b.colors[1]
# b.colors[0].red(99)
# puts b.colors[1].red
# puts "*********"
# p b.colors
# b.delete(colors: 0)
# b.delete(colors: :color22)
# b.delete(:colors)
# b.delete(true)
# b.delete([{ colors: 0 }, {colors: :color22}])

# puts "---- tests ----"
# b.colors.set({ red: 939 })
# the lines below create badly formatted atome

# b.colors.add({ red: 33 })
# b.colors.add({ red: 66, id: :new_col })
# b.colors.replace(1,{ red: 996 })
# b.colors.replace(:color1_id, { red: 393 })

# ------ make it works: ------
# b.color.add({ red: 66 }) # irrelevant as color is uniq!
# b.add(colors: { red: 999999 })
# puts '----New test -----'
# b.color({ blue: 9 })
# puts b.color
# puts b.colors[0].id
# puts '---------'
# # puts Utilities.users_atomes

# b.colors[0].id(:toto)
# puts b.colors[0].id
# puts '-----color 0----'
# puts b.colors[0]
# # puts '---------'
b.top(99)
# p b.top
# puts b.top
# puts "b.colors : #{b.colors}"
# puts '---------'
# puts b
# puts "we must integrate the file : atomeDeepIntegration \n check new tests\n
# methods modified :  id, colors, color, parent, particle_setter_helper, top"
# puts b.shapes

# puts "still need to test pre and post rendering processor"

# TODO: the id method is fucked!!