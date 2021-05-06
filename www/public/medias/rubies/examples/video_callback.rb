# video callback example

v = video(:superman)
t = text({ content: :timer, x: 600 })
v.touch do
  v.play(true) do |evt|
    t.content(evt)
  end
end

c = circle({ x: 333 })
c.text({ content: "pause", center: true })

c.touch do
  v.play(:pause)
end
c2 = circle({ x: 333, y: 69, color: :black })
c2.text({ content: "stop", center: true })

c2.touch do
  v.play(:stop)
end

d = circle({ x: 333, y: 120, color: :green })
d.text({ content: "play from 33", center: true })

d.touch do
  v.play(33)
end

