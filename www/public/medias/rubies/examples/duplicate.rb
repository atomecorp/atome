# duplicate

c = circle({x: 69, y: 69})
c.text("click me!")
c.touch do
  c.duplicate({x: 7, y: 7})
end