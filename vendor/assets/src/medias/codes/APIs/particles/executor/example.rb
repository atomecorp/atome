# frozen_string_literal: true
def act_on(obj)
  obj.color(:red)
  obj.left(56)
end

def act_off(obj)
  obj.color(:blue)
  obj.left(33)
end


b = box({ left: 12, id: :the_first_box, top: 30 })

b.touch(true) do
  b.alternate({ width: 33, color: :red, height: 33 , smooth: 0 }, { width: 66, color: :orange, blur: 8}, { height: 66, color: :green, smooth: 9, blur: 0})
end

c = circle({ left: 99 , top: 30})

c.touch(true) do
  alt = b.alternate(true, false)
  if alt
    c.color(:yellowgreen)
  else
    c.color(:orange)
  end
end


c2 = circle({ left: 333 , top: 30})


c2.touch(true) do
  b.alternate({  executor: {act_on: b}  }, { executor: {act_off: b}})
end
