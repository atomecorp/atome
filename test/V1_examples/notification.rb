# notification example

c = circle({ x: 6, y: 6 })
notification "element position is :#{c.x}, #{c.y}"
c.touch do
  c.x = c.x + 6
  c.y = c.y + 6
  notification "element position is :#{c.x}, #{c.y}"
end