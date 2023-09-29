# touch stop_event example

b = box
c = b.circle({ size: 30, center: true })

b.touch({ option: :down, stop: true }) do
  if b.width == 333
    b.width(66)
    b.color(:white)
  else
    b.color(:black)
    b.width(333)
  end
end

# stop option stop the propagation of the event
c.touch(option: :down, stop: true) do
  # b.color(:blue)

  if b.width == 333
    c.width(66)
    c.color(:orange)
  else
    c.color(:yellow)
    c.width(333)
  end
end
