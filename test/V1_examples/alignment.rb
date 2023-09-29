# alignment

box({ atome_id: :the_box, color: :orange, width: :auto, height: :auto, xx: 69, x: 69, yy: 69, y: 69 })
t = text({ content: "click the grey to get it's position", color: :red })

b = box({ atome_id: :toto, drag: true })
b.xx(88)
b.y(88)

b.touch do
  t.content("x: #{b.x}, y: #{b.y}, xx: #{b.xx}, yy: #{b.yy}")
  b.fixed(false)
end

b2 = box({ atome_id: :toto, drag: true, color: :purple })
c = circle({ y: 96, x: 33, atome_id: :the_circle, color: :magenta, drag: true })
c.center(:y)
b2.fixed(true)
b2.center(:all)
t1 = b2.text('O')
t2 = c.text("i")
t1.center({ reference: :parent, axis: :x })
t2.center({ reference: :the_circle, axis: :all })
img = image({ content: :boat, size: 69, x: 96, y: 33, drag: true })
# offset means that the current x and y position is added to the centering
img.center({ axis: :x, offset: true })