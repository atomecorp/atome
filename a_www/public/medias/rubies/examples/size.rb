

# size example
t1 = text({ content: :change_image, y: 9 })
t2 = text({ content: :change_parent, y: +t1.height + 9 })
t3 = text({ content: :fit, y: t2.y + t1.height + 9 })
t4 = text({ content: :fit_width, y: t3.y + t1.height + 9 })
t5 = text({ content: :fit_height, y: t4.y + t1.height + 9 })
t6 = text({ content: :fit_dynamic_scale_the_box_to_test, y: t5.y + t1.height + 9 })
t7 = text({ content: :overflow, y: t6.y + t1.height + 9 })
t8 = text({ content: :size_69, y: t7.y + t1.height + 9 })

#box 1
b = box({ x: 333, width: 333, height: 96, drag: true, atome_id: :the_box, color: :green })
#box 2
b2 = box({ color: :orange, x: 333, y: 123, width: 96, height: 333, drag: true, atome_id: :the_box2 })
i = b.image({ content: :sky, drag: true })

t1.touch do
  if i.content == :sky
    size_found = i.size
    i.delete
    i = b.image({ content: :moto, drag: true })
    i.size(size_found)
  elsif i.content == :moto
    size_found = i.size
    i.delete
    i = b.image({ content: :ballanim, drag: true })
    i.size(size_found)
  elsif i.content == :ballanim
    size_found = i.size
    i.delete
    i = b.image({ content: :eyes, drag: true })
    i.size(size_found)
  else
    size_found = i.size
    i.delete
    i = b.image({ content: :boat, drag: true })
    i.size(size_found)
  end
end

t2.touch do
  if i.parent.include?(b.atome_id)
    i.parent(b2.atome_id)
    grab(b.atome_id).extract(i.atome_id)
  else
    i.parent(b.atome_id)
    grab(b2.atome_id).extract(i.atome_id)
  end

  i.x = i.y = 0
end

t3.touch do
  i.size(:fit)
end

t4.touch do
  i.size({ fit: :width })
end

t5.touch do
  i.size({ fit: :height })
end

t6.touch do
  i.size({ dynamic: true })
  b.scale(true)
  b2.scale(true)
end

t7.touch do
  if b.overflow == :visible
    b.overflow(:hidden)
    b2.overflow(:hidden)
  else
    b.overflow (:visible)
    b2.overflow(:visible)
  end
end

t8.touch do
  i.size(69)
end
i.size(96)
t9 = text("test")
t9.x(123).touch do
  t9.content(i.size)
end

# #fixme :  quark should be able to read property, ex: alert i.parent.width # to get width
#
the_parent =grab(i.parent.last)
# alert grab(the_parent)
the_parent.monitor(true) do
  #fixme :  quark should be able to read property, ex: alert i.parent.width # to get width
  parent_atome = i.parent.read[0]

  if parent_atome.scale
    if i.size && i.size[:dynamic] == true
      i.size = i.size[:fit]
    end
  end
end
c = text({ content: "stop dynamic scale", y: 222 })
c.touch do
  the_parent.monitor({ option: false })
end
