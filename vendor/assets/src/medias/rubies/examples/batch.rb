# frozen_string_literal: true
# group
b=box({ id: :b1 })
b.box({ id: :b2, left: 220 })
b.box({ id: :b3, left: 340 })
grouped_object=group([:b2, :b3])

# grouped_object= b.color
 grouped_object.color(:blue)
# puts "----- group ------"
# puts "=> the group found is #{a}"
# p a.group.value


wait 1 do
 grouped_object.smooth(33).blur(9).color(:red)
end

wait 2 do
 grouped_object.rotate(33)
end

wait 3 do
 grouped_object.top(0)
end

wait 4 do
 grouped_object.shape({id: :the_shape, drag: true, left: 200})
end


wait 5 do
 grouped_object.circle
end


wait 6 do
 grouped_object.each do |el|
   el.height(77).blur(9)
 end
end


