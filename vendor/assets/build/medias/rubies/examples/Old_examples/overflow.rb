# overflow


b = text({x: 369, y: 30, content: "touch me to change text overflow"})
container=circle({width:300, height: 300, y: 99, drag: true})
container.text({content: lorem, x: 66, width: 300})
i=0
b.touch do
  case i
  when 0
    container.overflow(:hidden)
    i+=1
  when 1
    container.overflow(:scroll)
    i+=1
  when 2
    container.overflow(:visible)
    i=0
  else
    i
  end
end