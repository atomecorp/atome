# video callback example

t2=text({ content: :"play status", xx:333 } )
t2.touch do
  t2.content(v.play[:status])
end
v = video(:superman)
t = text({ content: :hello, xx: 96 })
v.touch do
  v.play(true) do |evt|
    t.content(evt)
  end
  t2.content(v.play[:status])
end

c = circle({ x: 333 })
c.text({ content: "pause", center: true })

c.touch do
  v.play(:pause)
  t2.content(v.play[:status])
end
c2 = circle({ x: 333, y: 69, color: :black })
c2.text({ content: "stop", center: true })

c2.touch do
  v.play(:stop)
  t2.content(v.play[:status])
end

d = circle({ x: 333, y: 120, color: :green })
d.text({ content: "play from 33", center: true })

d.touch do
  v.play(33)
  t2.content(v.play[:status])
end

