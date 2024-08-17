#  frozen_string_literal: true

b = box({ left: 333, color: :blue, smooth: 6, id: :the_box2 })

t = text({ id: :the_text, data: 'type of touch : ?' })

t.touch(:down) do |event|
  puts :down
  puts event[:pageX]
  puts event[:pageY]
  b.touch({ remove: :down })
  t.data('down removed !! ')
end

touch_code = lambda do
  b.color(:red)
  puts 'box tapped'
end
b.touch(tap: true, code: touch_code)

b.touch(:long) do
  { color: :cyan }
  t.data('type of touch is : long ')
end

b.touch(:up) do
  t.data('type of touch is : up ')
  b.color(:orange)
end

b.touch(:down) do
  t.data('type of touch is : down ')
  b.color(:white)
end

b.touch(:double) do
  t.color(:red)
  t.data('type of touch is : double ')
  b.color(:yellowgreen)
end



