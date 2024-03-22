# frozen_string_literal: true

# tick allow you to automatise any action counting
# it can be added into any new created particle ex: here a dummy

new({ particle: :dummy }) do |_p|
  tick(:dummy )
end

new({ particle: :dummy2 }) do |_p|
  tick(:dummy2 )
end

a=box
a.dummy(:hi)

puts a.tick[:dummy]
a.dummy(:ho)
puts a.tick[:dummy]

a.dummy2(:ho)
puts a.tick[:dummy2]

c=circle({left: 99})

c.touch(true) do
  c.tick(:my_counter)
  puts  c.tick[:my_counter]
end
