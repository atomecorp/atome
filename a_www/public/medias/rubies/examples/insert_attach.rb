# insert example

b=box({ color: :lightgray})
b.drag(true)
bb=box({ size: 20, x: -10 })
c=circle({  x: 35, color: :lightgray})
b.insert(c.atome_id)
b.insert(bb.atome_id)

b.drag(true)
b.shadow(true)
b.x(300)
b.y(300)