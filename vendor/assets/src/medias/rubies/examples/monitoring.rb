# frozen_string_literal: true

a = text({ data: "open the console!" })
a.right(44).left(66)

b = Atome.new(shape: { type: :shape, id: :my_shape, children: [], parents: [:view], renderers: [:browser],
                       left: 0, right: 33
})

c = Atome.new(shape: { type: :shape, id: :my_pix, children: [], parents: [:view], renderers: [:browser],
                       left: 50, right: 78
})

a.monitor({ atomes: grab(:view).children.value, particles: [:left] }) do |atome, element, value|
  puts "monitoring: #{atome.id}, #{element}, #{value}"
end

b.left(936)
b.left(777)
c.left(888)

# test 2
aa = text({ data: 'touch me and look in the console', top: 99, width: 399, left: 120 })
aa.touch(true) do
  aa.color(:red)
  aa.left(333)
  aa.width(555)
  aa.right(4)
  aa.height(199)
end

aa.box({ id: :theboxy })

aa.monitor({ atomes: grab(:view).children.value, particles: [:left] }) do |_atome, _element, value|
  puts "the left value was change to : #{value}"
end

aa.monitor({ atomes: grab(:view).children.value, particles: [:width] }) do |_atome, _element, value|
  puts "the width's value was change to : #{value}"
end

aa.monitor({ atomes: grab(:view).children.value, particles: [:left], id: :my_monitorer }) do |_atome, _element, value|
  puts "the second monitor left value was log to : #{value}"
end
