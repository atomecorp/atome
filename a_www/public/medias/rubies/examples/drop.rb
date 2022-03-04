# drop example
c = circle

b = box()
b.x(250)
b.drag(true)
c.x(390)
c.drop(true) do
  c.color (:black)
  c.y=c.y+33
end

c.touch do
  c.drop(false)
end