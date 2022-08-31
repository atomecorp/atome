require './atomic'


# methods generator

Genesis.new_atome(:color) do |params|
  puts "extra color code executed!! : #{params}"
end
Genesis.new_atome_helper(:color_render_pre_proc) do
  puts "Color helper pre render set\n"
end
Genesis.new_atome(:shape)
Genesis.new_atome(:drm)
Genesis.new_atome(:dna)
# tests
Genesis.new_particle(:red) do
  puts "extra red particle code executed!!"
end
Genesis.new_particle(:green)
Genesis.new_particle(:blue)
a = {
  id: :my_shapes_container,
  drms: { drm_id: { color: :read }, drm_id2: { red: :all } },
  dnas: { dna_id: { author: :jeezs, date: :a_10_06_33 } },
  shapes: { shape1_id: { width: 33, height: 999 }, shape2_id: { width: 666, height: 333 } },
  colors: { color1_id: { red: 0.3, green: 0.1 }, color2_2: { red: 0.9, green: 0.39 } }
}

Atome.new()

b = Atome.new(a)
# p '------ Results ------'
# b.color({red: 10})
b
# puts b.colors[1]
# b.colors[1].red(99)
# puts b.colors[1].red
# puts "*********"

b.delete(colors: 0)
b.delete(colors: :color2_2)
# b.delete(:colors)
# b.delete(true)
# b.delete([{ colors: 0 }, {colors: :color2_2}])

# b.colors.set({ red: 939 })
# b.colors.add({ red: 33 })
# b.colors.add({ red: 66, id: :new_col })
# b.colors.replace(1,{ red: 99 })
# b.colors.replace(:color1_id, { red: 33 })
# ------ make it works: ------
# b.color.add({ red: 66 }) # irrelevant as color is uniq!
# b.add(colors: { red: 999 })
puts '---------'
puts b
# puts b.shapes