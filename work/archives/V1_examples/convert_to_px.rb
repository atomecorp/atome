# convert api

c = circle()
c.xx(250)
c.yy(300)
c.width("33%")
t = text('resize the window')
t.y = 20
t.color(:white)
ATOME.resize_html(true) do |evt|
  new_size = c.convert(:width)
  t.content("width set : 33%, in pixel :\n" + new_size.to_s + " px")
end
t.x(450)