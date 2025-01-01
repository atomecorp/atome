# #  frozen_string_literal: true
b = box

first_wait=wait 2 do
  b.color(:red)
end
wait 1 do
  puts 'now'
  stop({ wait: first_wait })
  # or
  # wait(:kill, first_wait)
end


wait 3 do
  b.color(:green)
end