# scale example

b = box({ size: 96, x: 333 })
i = b.image({ content: :moto, size: :fit, drag: true })
t = text({ content: :size })
t2 = text({ content: "keep ratio", y: 33 })
t3 = text({ content: "no ratio", y: 66 })
t4 = text({ content: "scale box too", y: 96 })
t5 = text({ content: "stop scale", y: 129 })

def stop_scale(obj)
  if obj.scale && obj.scale.to_s != "destroy"
    obj.scale(:destroy)
  end
end

t2.touch do
  stop_scale(i)
  i.scale({ ratio: true }) do |width, height|
    t.content("#{width}, #{height}")
  end
end
t3.touch do
  stop_scale(i)
  i.scale() do |width, height|
    t.content("#{width}, #{height}")
  end
end
t4.touch do
  stop_scale(i)
  i.scale({ add: b.atome_id }) do |width, height|
    t.content("#{width}, #{height}")
  end
end
t5.touch do
  stop_scale(i)
end

i.scale do |width, height|
  t.content("#{width}, #{height}")
end