# over example

c = circle
c.x(250)
c.over(:enter) do
  c.color (:green)
end
c.over(:exit) do
  c.color (:blue)
end