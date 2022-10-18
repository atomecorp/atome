# play callback example:

v = video({ content: "madmax" })
t = text({ content: "play position", xx: 96, visual: 15 })
t2 = text({ content: :"play status", xx: 333, visual: 15 })

t2.touch do
  t2.content(v.play[:status])
end

v.touch do
  v.play(true) do |evt|
    t.content(evt)
  end
  t2.content(v.play[:status])
end

c = circle({ x: 333, y: 9 })
c.text({ content: "pause", center: true, visual: 15 })

c.touch do
  v.play(:pause) do |evt|
    t.content(evt)
  end
  t2.content(v.play[:status])
end

d = circle({ x: 333, y: 120, color: :black })
d.text({ content: "stop", center: true, visual: 15 })

d.touch do
  v.play(:stop) do |evt|
    t.content(evt)
  end
  t2.content(v.play[:status])
end

e = circle({ x: 333, y: 222, color: :green })
e.text({ content: "play from 33", center: true, visual: 15 })

e.touch do
  v.play(33) do |evt|
    t.content(evt)
  end
  t2.content(v.play[:status])
end
