# frozen_string_literal: true

a = text({data: "open the console!"})
a.right(44).left(66)

b = Atome.new(shape: { type: :shape, id: :my_shape, children: [],parents: [:view], renderers: [:browser],
                       left: 0, right: 33
})

c = Atome.new(shape: { type: :shape, id: :my_pix,children: [], parents: [:view], renderers: [:browser],
                       left: 50, right: 78
})

a.monitor({ atomes: grab(:view).children.value, particles: [:left] }) do |atome,element, value|
  puts "monitoring: #{atome.id}, #{element}, #{value}"
end

b.left(936)
b.left(777)
c.left(888)

#test 2
a = text({data: 'touch me and open the console'})

a.touch(true) do
  a.color(:red)
  a.left(333)
end

a.monitor({ atomes: grab(:view).children.value, particles: [:left] }) do |_atome,_element, value|
  puts  "the left value was change to : #{value}"

end
