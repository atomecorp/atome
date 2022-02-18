# monitoring
console = Atome.new({ atome_id: :console, parent: :intuition, type: :shape, width: :auto, x: 0, xx: 0, yy: 0, height: 33, color: { alpha: 0.3 } })
cc = Atome.new({ parent: :console, type: :text, content: :hello, color: :yellowgreen, x: 6, y: 6 })
console.touch do
  console.delete(true)
end

b = box({ x: 333, y: 50 })
text({ content: "drag the box", x: 33, y: 3, color: :orange })
t2 = text({ content: "start monitoring all", x: 33, y: 33 })
t3 = text({ content: "stop monitoring all", x: 33, y: 66 })

t4 = text({ content: "start monitoring the box", x: 33, y: 96 })
t5 = text({ content: "stop monitoring the box", x: 33, y: 123 })

i = 3
b.touch do
  b.smooth(i)
  i += 3
end
b.drag(true)
c = circle({ x: 333 })
c.drag(true)
t2.touch do
  properties = {}
  grab(:view).child.monitor(true) do |evt|
    properties[evt[:property]] = evt[:value]
    cc.content ("#{properties}\n")
  end

end

t3.touch do
  grab(:view).child.monitor({ option: false })
end

t4.touch do
  properties = {}
  b.monitor(true) do |evt|
    properties[evt[:property]] = evt[:value]
    cc.content ("#{properties}\n")
  end
end

t5.touch do
  b.monitor({ option: false })
end
