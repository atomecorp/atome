# objects in object

c=circle
b=c.box({x: 200, atome_id: :poil})
t=b.text({content: :ok})
t.center(true)
b.rotate(30)
c.drag(true) do |evt|
  b.rotate(evt.page_x)
  b.color(:green)
end

box({color: :orange, center: true, text: {content: :hello, color: :yellow, center: {reference: :parent, axis: :y}}})