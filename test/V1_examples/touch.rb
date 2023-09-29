# touch example

b = box({ x: 96, y: 6, text: { content: "on mouse down", center: true, color: :black } })
b.touch({ option: :down }) do
  b.color(:orange)
  b.x = b.x + 10
end
t = text({ content: "kill touch\non box" })
t.touch do
  b.touch({ remove: :true })
end

c = circle({ x: 33, y: 96, text: { content: "on mouse up", center: true, color: :black } })
c.touch({ option: :up }) do
  anim({
         start: { x: 0, y: 0, smooth: 0, rotate: 20 },
         end: { x: 400, y: 70, smooth: 25, rotate: 180 },
         duration: 2000,
         loop: 3,
         curve: :easing,
         target: c.atome_id
       })
end