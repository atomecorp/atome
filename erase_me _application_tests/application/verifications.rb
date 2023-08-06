# frozen_string_literal: true

require './new_engine'


a = Atome.new({ shape: { type: :shape, id: :a000, render: [:html],
                         left: 33, shape: { id: :a111, left: 96 },
                         color: { type: :color, id: :c00, render: [:html], red: 1, green: 0, blue: 0.7, alpha: 1, additional: [
                           { id: :c01, red: 0, green: 0, blue: 0.7, alpha: 1 },
                           { id: :c02, red: 1, green: 1, blue: 0.7, alpha: 1 }
                         ] } } }) do
  puts 'So coll!!'
end

# a.collapse
# puts a
a.left(333) do
  puts 'left is set!'
end

puts a.left
# puts a.id
# puts a.getter(:left)[:value]

# puts "---- #{a.left}"
# puts "---- #{a.left.value}"
# puts a.bloc.inspect
# a.inject_particle({left: 69})
# puts a.getter(:bloc)
# puts a.left
# puts "#{a.getter(:left)} : #{a.getter(:left).class}"
# puts ":: #{a.left}"

# puts a.color.id
# puts "::: #{a.left}"

# a.color({ id: :c03, red: 1, green: 1, blue: 1, alpha: 1, render: [:html] }) do
#   puts 'it works'
# end
# puts a.color
# a.shadow({ id: :s07, blur: 3, red: 0, green: 1, blue: 1, alpha: 1, render: [:html] }) do
#   puts "so so good!"
# end
# puts a.color.bloc
# puts "Color is: #{a.color}"
# puts "Shadow is: #{a.shadow}"
# puts a.shadow.red
# puts a