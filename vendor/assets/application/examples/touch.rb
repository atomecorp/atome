#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
b.touch(true) do
  b.color(:red)
end

b.touch(:long) do
  b.color(:black)
end

b.touch(:up) do
  puts :up
end

b.touch(:down) do
  b.color(:white)
end

b.touch({ double: true }) do
  b.color(:yellowgreen)
end

b.touch(true) do
  puts 'ok'
end

wait 7 do
  b.touch(false)
  text('finished')
end