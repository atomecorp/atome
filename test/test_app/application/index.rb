# frozen_string_literal: true

# Verification
a = Atome.new(shape: { type: :shape, id: :the_sender, parent: :view, render: [:html],
                       left: 33, right: 7,
                       # video: { type: :video, id: :xxx, render: [] },
                       #
                       # image: { type: :image, id: :im02, render: [:html], red: 1, green: 0, blue: 0.7, alpha: 1,
                       #          additional: [
                       #            { id: :c01, red: 0, green: 0, blue: 0.7, alpha: 1 },
                       #            { id: :c02, red: 1, green: 1, blue: 0.7, alpha: 1 }
                       #          ] },
                       #
                       # color: { type: :color, id: :c09, render: [:html], red: 1, green: 0, blue: 0.7, alpha: 1,
                       #          additional: [
                       #            { id: :c01, red: 0, green: 0, blue: 0.7, alpha: 1 },
                       #            { id: :c02, red: 1, green: 1, blue: 0.7, alpha: 1 }
                       #          ] },
                       # shape: { id: :a111, left: 96, render: [:html], type: :shape }
}) do
  puts 'So coolly!!'
end
a.right(44).left(66)

b = Atome.new(shape: { type: :shape, id: :my_shape, parent: :view, render: [:html],
                       left: 5, right: 75,
})

c = Atome.new(shape: { type: :image, id: :my_pix, parent: :view, render: [:html],
                       left: 5, right: 75,
})

# alert a.right
# alert a.right.class
a.type(:image) do
  puts :image_callback_passed
end
a.left(88) do
  puts 'so cool'
end
# a.red(:ok)
# a.red.set(99)
# puts a.red
# puts a.left

#
# bloc_found=a.bloc.value
# instance_exec(&bloc_found) if bloc_found.is_a?(Proc)
#
# # puts a
# # puts a.left.set(99)
# # a.left(999)
#
#
# puts a.get(:left)
# puts "a.left : #{a.left}"
#
# # puts a.left
# # puts a
# # a.set(:left, 77)
# # puts a
# # puts a.get(:left)
# # a.inject_particle({ left: 69 })
# # puts a.getter(:left)
# # a.collapse
# # a.collapse
# # a.left(39)
#
# # a.left(7) do
# #   puts '=> it works,callback from left (always twice!)'
# # end
# # puts a.bloc
# # puts a
# # puts a
# # a.left(333) do
# #   puts 'left is set!'
# # end
# #
# # puts a.left
# # a.left(999)
# #
# # puts a.id
#
# # puts "---- #{a.left}"
# # puts "---- #{a.left.value}"
# # puts a.bloc
# # a.inject_particle({ left: 69 })
# # puts a.left
# # puts a.getter(:bloc)
# # puts a.left
# # puts "#{a.getter(:left)} : #{a.getter(:left).class}"
# # puts ":: #{a.left}"
# puts "====== > color is  #{a.color}"
# # puts a.color.id
# # puts "::: #{a.left}"
# # a.color({ id: :c03, red: 1, green: 1, blue: 1, alpha: 1, render: [:html] }) do
# #   puts '--> it works for the color callback (always twice!)'
# # end
# # puts "=> #{a.color.bloc}"
# # puts "id is : #{a.id}"
# # puts a.bloc
# # puts a.color.bloc
# # a.shadow({ id: :s07, blur: 3, red: 0, green: 1, blue: 1, alpha: 1, render: [:html] }) do
# #   puts "so so good!"
# # end
# # puts a.color.bloc
# # puts "Color is: #{a.color}"
# # puts "Shadow is: #{a.shadow}"
# # puts a.shadow.red
# # puts a
# # Atome.atomes.each do |atome_found|
# #   puts "::: #{atome_found}"
# # end
#
# # unacessible variable example below
# # class Foo
# #
# #   private
# #
# #   def initialize
# #   end
# #
# #   def private_setter(val)
# #     define_singleton_method(:unaccessible_method) { val }
# #   end
# #
# #   public
# #
# #   def setter(value)
# #     private_setter(value)
# #   end
# #
# #   def getter
# #     unaccessible_method
# #   end
# #
# # end
# #
# # foo = Foo.new()
# #
# # foo.setter(999)
# # puts "foo.getter : #{foo.getter}"
# # # puts foo.x  # => 2
# # puts "foo.instance_variable_get : #{foo.instance_variable_get(:@x)}"
#
# # puts Foo.instance_variable_get(:@x)  # => nil
#
# # def creation_common
# #   puts 'Start of method'
# #   # you can call the block using the yield keyword.
# #   yield
# #   puts 'End of method'
# #
# #   yield
# # end
# #
# # def particle_method(value)
# #   creation_common do
# #     puts value
# #   end
# # end
#
# # particle_method(:jeezs)
# # puts "-----"
# # puts "color : #{a.color}"
#
# a.set_atome({ shape: { id: :a123, left: 96, render: [:html], type: :shape } })
# # puts Atome.atomes.length
# # puts a.left
# # Atome.atomes.each_with_index do |atome_found, index|
# #   puts "new atome :#{atome_found}"
# #   puts '***'
# # end
#
#
#
# # to call instance method
# # puts MyClass.my_class_method

a.left(33) do
  puts 'ok were on!!'
end

a.left do
  puts "so cool it's incredible!!"
end

puts 'hello world'

require 'application/required_example'

generator = Genesis.generator


# puts grab(:a000)
a.monitor({ atomes: [:my_shape], particles: [:left, :right] }) do |atome, element, value|
  alert "hello from: #{atome.id}, #{element}, #{value}"

end

a.monitor({ atomes: [:my_pix], particles: [:red] }) do |atome,element, value|
  alert "kool from: #{atome.id}, #{element}, #{value}"
end

# a.monitor({ atomes: [:the_sender], particles: [:bottom] }) do |element, value|
#   puts 'hello from bottom'
# end
b.left(936)

c.red(777)
alert grab(:view).children
# a.create_particle(:left, 88)

# c.left(:red)

# alert grab(:my_pix)
# alert a
# alert a.right(44)
# grab(:my_shape).broadcast({ my_shape: { atome: "self", "params[:particles]" => :proc_monitoring } })

# puts "---id---> #{a.id.class}"
# puts "--left----> #{a.left.value}

# alert  "broadcast is : #{grab(:my_shape).broadcast}"
# alert  "broadcast2 is : #{a.broadcast}"

# b = Atome.new(shape: { type: :shape, id: :the_shape, parent: :view, render: [:html],
#                        left: 66, right: 3
#                        # video: { type: :video, id: :xxx, render: [] },
#                        #
#                        # image: { type: :image, id: :im02, render: [:html], red: 1, green: 0, blue: 0.7, alpha: 1,
#                        #          additional: [
#                        #            { id: :c01, red: 0, green: 0, blue: 0.7, alpha: 1 },
#                        #            { id: :c02, red: 1, green: 1, blue: 0.7, alpha: 1 }
#                        #          ] },
#                        #
#                        # color: { type: :color, id: :c09, render: [:html], red: 1, green: 0, blue: 0.7, alpha: 1,
#                        #          additional: [
#                        #            { id: :c01, red: 0, green: 0, blue: 0.7, alpha: 1 },
#                        #            { id: :c02, red: 1, green: 1, blue: 0.7, alpha: 1 }
#                        #          ] },
#                        # shape: { id: :a111, left: 96, render: [:html], type: :shape }
# })
# alert "broadcast3 is : #{b.broadcast}"