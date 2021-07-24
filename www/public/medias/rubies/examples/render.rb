# render

t=text("touch to circle to remove the circle from rendering")
c = circle({atome_id: :c, x: 300, y: 66})
c.touch do
  c.render(false)
  ATOME.wait 2 do
    c.render(true)
  end
end