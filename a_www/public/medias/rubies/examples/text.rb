# text

b=box({ atome_id: :tutu, y: 96,x: 96, width: 333,height: 333, overflow: :auto})
t=text({content: lorem, color: :red,   atome_id: "toto", width: :auto})
scale=text({content: :scale, x: 9, y: 9})
drag=text({content: :drag, x: scale.x+100, y: 9})
margin=text({content: :margin, x: drag.x+100, y: 9})
format=text({content: :format, x: margin.x+100, y: 9})
edit=text({content: :edit, x: format.x+100, y: 9})
fit=text({content: :fit, x: edit.x+100, y: 9, color: :white})
scale.touch do
  t.visual(25)
  t.scale(true) do |evt|
    #puts evt
  end
end
fit.touch do
  t.parent(b.atome_id)
end
edit.touch do
  t.edit(true)
end
margin.touch do

  t.set(width: :auto,height: :auto, x: 33, xx: 33)
end
format.touch do
  b.scale(true) do

  end
end
drag.touch do
  b.drag(true)
end