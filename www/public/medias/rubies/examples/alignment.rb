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