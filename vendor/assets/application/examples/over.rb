#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
b.over(true) do
  b.color(:black)
  # puts "I'm inside"
end
b.over(:enter) do
  puts "in"
  puts "enter"
  b.width= b.width+30
  # alert :in
  b.color(:yellow)
end
b.over(:leave) do
  b.height= b.height+10
  puts "out"
  puts "leave"
  # alert :out
  b.color(:orange)
end

#
t=b.text('touch me to stop over leave')
b.touch(true) do
  b.over({ remove: :enter })
  t.data('finished')
end

