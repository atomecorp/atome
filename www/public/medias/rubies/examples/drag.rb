# drag

t=text({content:  "drag the grey box!", x: 33, y: 33 })
t2=text({content:  "click me to destroy drag on the moto", x: 33, yy: 96 })

b=box({center: true})
b.drag(true) do |evt|
  b.rotate(evt.page_x)
  t.content("pointer x: #{evt.page_x},
  pointer Y: #{evt.page_y},
  offset x: #{evt.offset_x},
  offset y: #{evt.offset_y},
  box x: #{b.x},
  box y: #{b.y},
")
end
dragger=box({width: 96, height: 96, x:333, y: 200})
handle=dragger.box({width: 96, height: 16, color: :orange, atome_id: :the_handle})
handle.text({content: "drag me from here", size: 12, color: :black})
dragger.drag({handle: :the_handle}) do |evt|
  t.content("I can only be dragged using the bar above")
end
c=circle({y:66,x: 333, drag:{lock: :y}, color: :purple})
c.drag({lock: :y}) do
  t.content("I can only be dragged along the x axis")
end

container=box({width: 123, y:333,x: 333,color: :yellowgreen, smooth: 6, drag: true})

circle1=container.circle({y:0,x: 0,width: 33,height: 33,  color: :black})
circle1.drag({containment: :true}) do
  t.content("I am restricted to the parent")
end

circle2=container.circle({y:0,x: 96,width: 33,height: 33,  color: :red})
circle2.drag({containment: :view, grid: {x:33, y:33}}) do
  t.content("I am restricted to the view and my movement is constraint by a grid")
end

img=image({content: :moto,x: 33, y: 33, size: 132})
img.drag({containment:{x:33, y: 33, xx: 333, yy: 333}}) do |evt|
  if evt.start
    t.content("I am restricted to a confined area")
    t.color(:white)
  elsif evt.stop
    t.content("on stop x is : #{evt.page_x}, y is:  #{evt.page_y}")
    t.color(:red)
  else
    c.width=evt.offset_x
  end
end

boat=image({ content: :boat, size: 132,y: 333 })
boat.drag({ fixed: true }) do |evt|
  img.blur(evt.offset_x/66)
  img.size(evt.offset_x/6+132)
  t.content("drag the boat will change tha property of the moto")
end
t2.touch do
  img.drag(:destroy)
end