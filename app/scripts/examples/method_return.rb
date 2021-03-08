b = box({x: 220})
c = circle({x: 77})
c.x = b.x
b.x(50).blur(5).drag(true)