# right management example

b = box({atome_id: :the_box, x: 99})
b.touch do
  alert 'poil'
  b.authorization({ users: :all, write: false, password: :my_secret })
  b.color(:red, "false pass")
  b.color(:yellowgreen, b.authorization[:password])
  b.x(99, :my_secret)
  b.width(99, :my_secret)
end

b2 = b.box({ x: 333, atome_id: :the_box2 })
b2.drag(true)
c = circle({ y: 96 ,atome_id: :the_circle})
c.touch do
  clear(:view)
  Atome.atomes.each do |atome|
    alert atome[0]
  end
end