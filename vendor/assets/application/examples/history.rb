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
  alert b.retrieve({ operation: :write, id: :the_box, particle: :data })
end
puts b.history({ operation: :write, id: :the_box, particle: :rotate })
Universe.synchronised(742, :star_wars)
puts "b history is : #{b.history({ operation: :write, id: :the_box, particle: :rotate })}"