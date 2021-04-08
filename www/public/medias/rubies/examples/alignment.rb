b=box({atome_id: :titi,color: :orange, width: :auto, height: :auto,xx: 3, x: 3, yy: 3, y: 3})
t=text({content:  "play position", color: :black })

# t=text(:guide)
# c=circle
# c.drag(true)
b=box({atome_id: :toto, drag: true})
# b.fixed(true)
# b.center(:all)
# b.position(:fixed)
b.xx(88)
b.y(88)

b.touch do
  t.content("x: #{b.x}, y: #{b.y}, xx: #{b.xx}, yy: #{b.yy}")
  b.fixed(false)

end

# b.alignment({horizontal: :x, vertical: :yy})
# alert b.alignment

b2 = box({atome_id: :toto, drag: true, color: :purple})
c = circle({y: 96,x: 33,  atome_id: :the_circle, color: :magenta, drag: true})
c.center(:y)
b2.fixed(true)
b2.center(:all)
t = b2.text('O')
t2 = c.text("i")
t.center({reference: :parent, axis: :x})
t2.center({reference: :the_circle, axis: :all})
img=image({content: :boat, size: 69, x: 96, y: 33})
# offset means that the current x and y position is added to the centering
img.center({axis: :x, offset: true})