# render

t=text("touch to circle to stop rendering")
c = circle({atome_id: :c, x: 300})
c.touch do
  c.render(false)
end