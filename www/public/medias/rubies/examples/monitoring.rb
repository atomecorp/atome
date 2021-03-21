# monitoring

b = box({x: 220, y: 50})
t = text({content: "drag the box", x: 66})
t.touch do
  b.color(:red)
end
i=3
b.touch do
  b.smooth(i)
  i+=3
end
b.drag(true)
properties={}
b.monitor(:ok) do |evt|
  properties[evt[:property]]=evt[:value]
  t.content("\n#{properties}")
end