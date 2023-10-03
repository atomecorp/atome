# gradient

c = circle({ atome_id: :c, x: 300, id: :gradient_simple })
c.color({ green: 1 })
c.color ([:blue, :cyan])
c.size = 223
grad = text({ content: :kool, atome_id: :gradient_test, visual: 333 })
grad.x(333)
grad.y(99)
grad.size = 666
grad.color([:red, :yellow, { red: 0, green: 1, blue: 0 }, { angle: 150 }, { diffusion: :linear }])
grad.shadow(true)
ATOME.wait 1 do
  grad.color([:red, :yellow, { red: 0, green: 1, blue: 0 }, { angle: 150 }, { diffusion: :radial }])
end
ATOME.wait 2 do
  c.color([:cyan, :green, :orange, { diffusion: :conic }])
end
ATOME.wait 3 do
  grad.color([:orange, { red: 0, green: 1, blue: 0 }, :blue, { angle: 150, diffusion: :linear }])
end
grad.touch do
  text(grad.inspect)
end
