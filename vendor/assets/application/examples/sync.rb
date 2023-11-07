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
  # operation has two option write or read, it filter the history on those two options,  write retrieve all alteration
  # of the particle , read list everytime a particle was get
  # id retrieve all operation on a given ID
  # particle retrieve all operation on a given particle
  # alert b.retrieve({ operation: :write, id: :the_box, particle: :data })
end


# alert b.instance_variable_get('@history')
box_rotate_history=b.history({ operation: :write, id: :the_box, particle: :rotate })
puts "get all all rotate write operation :  #{box_rotate_history}"
first_rotate_operation_state=b.history({ operation: :write, id: :the_box, particle: :rotate })[0][:sync]

# we check if an operation synced (that means saved on atome's server)
puts "first rotate operation state  :  #{box_rotate_history[0]}"

# we check if an operation synced (that means saved on atome's server)
puts "first rotate operation initial state  :  #{box_rotate_history[0]}"
puts "synced  :  #{first_rotate_operation_state}"
first_rotate_operation_number=b.history({ operation: :write, id: :the_box, particle: :rotate })[0][:operation]
puts "first rotate 'write' operation number is:  #{first_rotate_operation_number}"

# now we sync the state
Universe.synchronised(first_rotate_operation_number, :star_wars)
# now we check if it's synced
box_rotate_history=b.history({ operation: :write, id: :the_box, particle: :rotate })
puts "new state for first rotate operation : #{box_rotate_history[0]}"
