# frozen_string_literal: true

require './generator'

# # puts Atome.atomes
#
# @tata= %w[a b c d e f]
# @toto= %w[g h i j k l]
# @titi= %w[m n o p q r]
# @tete= %w[s t u v w x]
#
# @atoms=[@tata, @toto]
# @particles=[@titi, @tete]
#
# all=@atoms+@particles
# new_array=[]
#  all.each do |each_found|
#    each_found.each do  |prop|
#      new_array << prop
#    end
#  end
#
# puts new_array.length

# Universe = Atome.new({})

Universe = Atome.new({ spaces: { universe: { width: '100%', height: '100%', left: 0, top: 0, parent: false,
                                             colors: { universe_color: { red: 1, green: 1, blue: 0, alpha: 0, top: 0,
                                                                         left: 0, diffusion: :linear } } } } })
puts Universe.spaces
#
# Universe = Atome.new({ spaces: [{ id: :myspace, width: '100%', height: '100%', left: 0, top: 0, parent: false,
#                                              colors: [ {id: :my_col, red: 1, green: 1, blue: 0, alpha: 0, x: 0,
#                                                                          y: 0, diffusion: :linear } ] } ] })


# View = Atome.new(identity: {},space: {name: :view}, shape:{name: :the_shape})

# puts View.space
# a = Atome.new({ id: :my_shape, left: 33, top: 99 })
# puts a
# b = shape({ x: 99, y: 99, width: 66, height: 66, left: 8 }) do
#   puts "hello\n" * 99
# end
#
# puts "left : #{b.left}"
# b.left(33)
# puts b
# c = b.shape({}) do
#   puts "kjhkjhkj"
# end
# puts c
#   puts "so cool"*99
# end
# puts Atome.atomes
#
# puts s.shape
# a.type(:image)
# # puts a.type
# a.left(33)
# a.color({red: 0.1, green: 0.2})
# # puts "color : #{a.color}"
# # line below must thrown an error
# # a.historize(:poil, :toto)
#
# a.id(:my_new_shape)
# # #### add an atome
# # a.color({yellow: 0.3, alpha: 0.2})
# a.color= {yellow: 0.3, alpha: 0.2}
# a.child({ content: :my_child })
# a.color.left({ val: 369 })
# a.color.red(:blue)
# a.color.red=:pink
# # #### add some atomes
# # a.color({ blue: 0.6 })
# # puts a.color.red
# a.colors(:orange)
# a.colors(:red)
# a.children(:poili)
# # puts a.colors.atomes
# # puts a.children.atomes
# # puts "------------- a -------------"
# # puts a.shapes.type
# # puts "------------- a.color -------------"
# # puts a.color
# # puts "------------- a.colors -------------"
# # puts a.colors
# # puts "------------- a.children -------------"
# # puts a.children
# # a.colors(0.9)
# # a.colors(0.33)
# # a.colors(0.93)
# # a.colors(0.393)
# # a.colors(0.993)
# # a.colors(0.999)
# # a.colors(0.399)
# # a.colors(0.999)
# # a.colors.children(:toto)
# # a.colors.children[0].id(:child1)
# # # more complex operations
# # a.colors.left(666)
# # a.colors.id(:the_cols)
# # a.colors.id(:my_cols_collection)
# # i = 0
# # a.colors.each do
# #   id_created = "color_#{i}"
# #   i += 1
# #   id(id_created)
# #   # puts self.class
# #   top(636)
# # end
# # a.colors[0].type(:image)
# #
# # a.colors.grab(:child1).type(:image)
# # a.colors[1..3] do
# #   # puts color
# #   left(603)
# # end
# # a.colors[1..3].top(333_333)
# # a.colors.last.top(909)
# # a.children.first.type(:text)
# # a.colors.all.green(:green_color)
# # puts a.colors.grab(:child1)
# # puts a.children.first.type
# # puts a.colors
# # a.colors[1..3].type(:poil)
# # puts a.colors[1..3].class
# # puts a.colors[0..3].type
# # puts a.colors[2].type
# # # simple operations
# #
# # a.colors.content.each do |col|
# #   puts col
# # end
# # puts a
# # puts "a.colors.length : #{a.colors.length}"
# # puts a.colors
# # puts a.id
# # puts "a.colors.id: #{a.colors.id}"
# #
# # puts "a content is : #{a}"
# # puts "a.color.class : #{a.color.class}"
# # puts "a.color : #{a.color}"
# # puts "a.colors.class : #{a.colors.class}"
# # puts "a.colors : #{a.colors}"
# # puts a.history
# # a.colors.each do
# #   puts self.id
# # end
#
