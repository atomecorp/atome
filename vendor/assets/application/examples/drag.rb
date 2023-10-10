#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
b.drag(true) do
  puts 'ok'
end

b.drag(:start) do
  b.color(:black)
end

b.drag(:stop) do
  b.color(:white)
end

b.drag(true) do
  puts 'ok'
end

wait 7 do
  b.drag(false)
  puts 'finished'
end