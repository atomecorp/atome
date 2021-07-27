# double and long touch example
b=box
b.touch ({ option: :double, delay: 0.6 }) do
  # b.x=b.x+60
  if b.color==:yellow
    b.color=:green
  else
    b.color=:yellow
  end
end
c=circle({ x: 99 })

c.touch ({ option: :long, delay: 1 }) do
  # c.x=c.x+60
  if c.color==:red
    c.color=:blue
  else
    c.color=:red
  end
end