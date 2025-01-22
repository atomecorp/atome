#  frozen_string_literal: true




a = element({ id: :timer_1 })
a.timer({ start: 3333, end: 3339 }) do |val|
  puts ">>#{val}<<"
end


