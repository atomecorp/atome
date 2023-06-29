# frozen_string_literal: true
# group

b = box({ id: :b1, drag: true })
b.box({ id: :b2, left: 220, drag: true })
b.box({ id: :b3, left: 340, drag: true })
grouped_object = group([:b2, :b3, :b1])
# b.text(:hello)
grouped_object.text(:blue)

grouped_object.color(:orange)

wait 1 do
  grouped_object.smooth(33).width(9).color(:red)
  puts "passed 1"
end

wait 2 do
  grouped_object.rotate(33)
  puts "passed 2"
end

wait 3 do
  grouped_object.top(0)
  puts "passed 3"
end

wait 4 do
  grouped_object.shape({ id: :the_shape, drag: true, left: 200 })
  puts "passed 4"
end

wait 5 do
  grouped_object.each do |el|
    el.height(77).blur(9)
  end
  puts "passed 5"
end

wait 6 do
  # Atome.new
  grouped_object.circle({})
  circle({ renderers: [:browser] })
  puts "passed 6"
end
wait 7 do
  # alert b
  b.circle({ color: :yellow })
  puts "passed 7"

end





