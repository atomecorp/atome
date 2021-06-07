# shadow example

b = box({ id: :box_test, x: 160, y: 160 })
b.text("touch me")

b.shadow({ x: 5, y: 5, blur: 7, color: :black, thickness: 0, invert: true })
b.shadow({ add: :true, x: 20, y: 20, color: "rgba(0,0,0,1)", blur: 16, thickness: 0 })
c = circle({ x: 96, y: 96, drag: true, id: :circle_test })
c.shadow({ x: -5, y: -5, blur: 16, color: :black, invert: :true, thickness: 0 })
c.shadow({ x: 0, y: 0, color: "rgba(0,0,0,1)", blur: 16, thickness: 0 })
b.drag(true)
# b.insert(c)
b.color(:orange)
t = text({ content: :hello, size: 33, x: 33, y: 33, drag: true })
t.blur(2)
t.shadow({ x: 3, y: 3, color: "rgba(0,0,0,1)", blur: 3, thickness: 0 })
t.shadow({ x: 3, y: 33, color: "rgba(0,0,0,1)", blur: 3, thickness: 0 })
img = image({ content: :boat, size: 96, x: 196, drag: true })
img.shadow({ x: 7, y: 3, color: "rgba(0,0,0,0.5)", blur: 7, thickness: 0 })
img.shadow({ x: -66, y: 3, color: "rgba(0,0,0,0.6)", blur: 17, thickness: 0 })

b.touch do
  b.shadow(false)
end