#  frozen_string_literal: true

b = box({ id: :the_box })
b.data(:canyouwritethis)
b.rotate(33)
b.rotate(88)
b.rotate(99)
b.rotate(12)
b.rotate(6)
b.data
b.touch(true) do
  b.data(:super)
  b.data
  box_data_write_history=b.history({ operation: :write, id: :the_box, particle: :data })
  puts "get data write operation :  #{box_data_write_history}"
  box_data_read_history=b.history({ operation: :read, id: :the_box, particle: :data })
  puts "get data read operation :  #{box_data_read_history}"
end



box_rotate_history=b.history({ operation: :write, id: :the_box, particle: :rotate })
puts "get all all rotate write operation :  #{box_rotate_history}"

# we check if an operation synced (that means saved on atome's server)
puts "first rotate operation state  :  #{box_rotate_history[0]}"

box_data_history=b.history({ operation: :write, id: :the_box, particle: :data })
puts "get data write operation :  #{box_data_history}"


