#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
b.over({ :over => true }) do
  puts 'ok'
end
b.over({ enter: true }) do
  b.color(:yellow)
end
b.over(:leave) do
  b.color(:red)
end

wait 7 do
  b.over(false)
  text('finished')
end