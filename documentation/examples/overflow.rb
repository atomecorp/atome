# overflow

t = text({content: lorem, x: 66, width: 300, height: 100})
t.color(:red)
b = text({x: 369, y: 50, content: "touch me to change text overflow", width: 333})
i=0
b.touch do
  case i
  when 0
    t.overflow(:hidden)
    i+=1
  when 1
    t.overflow(:scroll)
    i+=1
  when 2
    t.overflow(:visible)
    i=0
  end
end