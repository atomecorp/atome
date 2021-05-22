# touch stop_event example

b=box
c=b.circle({size: 30, center: true})

b.touch do
  b.color(:red)
end
# stop option stop the propagation of the event
c.touch(stop: true) do
  b.color(:blue)
  c.color(:yellow)
end
