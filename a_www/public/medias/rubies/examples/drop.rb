# drop example

b = box()
b.x(250)
b.drag(true)
c = circle
c.x(390)
c.drop(true) do |evt, ui|
  dropped_element= `$(ui.draggable).attr('id')`
  if  grab(dropped_element).color==:red
    grab(dropped_element).color(:orange)
  else
    grab(dropped_element).color(:red)
  end
  c.color (:black)
  c.y=c.y+33
end

c.touch do
  c.drop(false)
end

