# mask example

b = box({ color: :transparent, x: 66 })
v = b.video({ content: :avengers, size: 666 })
b.width = v.width
b.height = v.height
v.drag(true)
v.touch do
  v.play(true)
end
# i=image({ content: :beach , size: 666})
v.touch do ||
  v.mask({ content: :atome, size: 333, position: :center })
end
b.shadow({ x: 7, y: 3, color: "rgba(0,0,0,0.5)", blur: 7 })