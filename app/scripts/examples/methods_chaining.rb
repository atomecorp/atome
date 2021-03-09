# methods_chaining

b = box({x: 220})
c = circle({x: 77})
c.x = b.x
b.x(50).blur(5).drag(true)

batch([b,c,]).y(66).color(:cyan).rotate(33).blur(3)