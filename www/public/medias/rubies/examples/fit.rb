# fit example

b = box({ size: 96 })
b.image({ content: :boat, size: :fit })
b.touch do
  clear(:view)
end
b2 = box({ x: 333 })
t = b2.text({ content: "hit the red or orange circle", visual: :Impact })
t.width(96)

c0 = circle({ size: 33, x: 96, color: :yellowgreen })
c = circle({ size: 33, x: 120 })
c2 = circle({ size: 33, x: 150, color: :orange })

c0.touch do
  t.visual({ fit: :width })
  b2.size({ fit: t.atome_id })
  t.center(true)
end
c.touch do
  t.visual({ fit: :width })
  b2.size({ fit: t.atome_id, margin: { x: 33, y: 33 } })
  t.center(true)
end

c2.touch do
  t.visual({ fit: :width })
  b2.size({ fit: t.atome_id, margin: 66 })
  t.center(true)
end