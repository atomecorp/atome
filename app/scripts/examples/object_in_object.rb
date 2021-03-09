# objects in object

c=circle
b=c.box({x: 200, atome_id: :poil})
b.text(:ok)
b.rotate(30)
c.drag(true) do |evt|
  b.rotate(evt.page_x)
  b.color(:green)
end
