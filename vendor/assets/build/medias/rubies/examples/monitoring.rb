
a = Atome.new(shape: { type: :shape, id: :the_sender, parent: :view, render: [:html],
                       left: 33, right: 7
})
a.right(44).left(66)

b = Atome.new(shape: { type: :shape, id: :my_shape, parent: :view, render: [:html],
                       left: 0, right: 33
})

c = Atome.new(shape: { type: :image, id: :my_pix, parent: :view, render: [:html],
                       left: 50, right: 78
})


a.monitor({ atomes: grab(:view).children.value, particles: [:left] }) do |atome,element, value|
  puts "monitoring: #{atome.id}, #{element}, #{value}"
end


b.left(936)
c.left(888)