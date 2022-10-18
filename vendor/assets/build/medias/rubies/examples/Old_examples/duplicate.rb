# duplicate

c = circle({ x: 69, y: 69, drag: true })
c.text({ content: :ok, color: :yellow, size: 33, center: true })
t = text({ content: 'touch me!' })
t.touch do
  c.duplicate({ x: 7, y: 7 })
end
c.touch do
  c.duplicate({ x: 3, y: 3 })
end