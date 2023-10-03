# over example

# over example
c = circle
c.x(250)
c.over(:enter) do
  c.color (:green)
end
c.over(:exit) do
  c.color (:blue)
end

c.touch do
  c.over(false)
end