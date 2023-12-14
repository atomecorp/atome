#  frozen_string_literal: true
a=box({width: 666, height: 777, color: :orange})
b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2, depth: 1 })
cc=circle({color: :red, left: 0, top: 0})
clone = ""
b.drag(:start) do
  b.color(:black)
  b.height(123)
  # beware you must use grab(:view) else it'll be attached to the context, that means to 'b' in this case
  clone = grab(:view).circle({ id: "#{b.id}_cloned",color: :white, left: b.left, top: b.top, depth: 3 })
end

b.drag(:stop) do
  b.color(:purple)
  b.height=b.height+100
  clone.delete(true)
end



b.drag(:locked) do |event|
  dx = event[:dx]
  dy = event[:dy]
  x = (clone.left || 0) + dx.to_f
  y = (clone.top || 0) + dy.to_f
  clone.left(x)
  clone.top(y)
  puts "x: #{x}"
  puts "y: #{y}"
end
cc.drag({ restrict: {max:{ left: 240, top: 190}} }) do |event|

end


c=circle

c.drag({ restrict: a.id }) do |event|

end

t=text({data: 'touch me to unbind drag stop for b (clone will not deleted anymore)', left: 250 })
t.touch(true) do
  b.drag({remove: :stop})
end