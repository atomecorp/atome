#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
b.over(true) do
  b.color(:black)
  puts "I'm inside"
end
b.over(:enter) do
  b.color(:yellow)
end
b.over(:leave) do
  b.color(:red)
end
t=b.text('touch me to stop over enter')
t.touch(true) do
  b.over({ remove: :enter })
  t.data('finished')
end