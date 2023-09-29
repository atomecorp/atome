# virtual_event example

c = circle({ atome_id: :circle_1 })

c.touch do
  if c.color == :red
    c.color(:yellowgreen)
  else
    c.color(:red)
  end
end

t = text({ content: "touch me send a virtual touch to the circle", x: 99 })

t.touch do
  grab(:circle_1).virtual_event({ event: :touch, x: 30, y: 30 })
end