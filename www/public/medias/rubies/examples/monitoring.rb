# monitoring

b = box({x: 220, y: 50})
t = text({content: "drag the box", x: 33,y: 96})
t2 = text({content: "start monitoring", x: 33,y: 33})
t3 = text({content: "stop monitoring", x: 33,y: 66})

i=3
b.touch do
  b.smooth(i)
  i+=3
end
b.drag(true)

t2.touch do
  properties={}
  b.monitor(true) do |evt|
    properties[evt[:property]]=evt[:value]
    t.content("\n#{properties}")
  end
end

t3.touch do
  b.monitor({ option: false })
end