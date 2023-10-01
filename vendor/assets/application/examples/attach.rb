# frozen_string_literal: true

b = box({ id: :c315 })
circle({ id: :c_12, top: 0, drag: true })
wait 1 do
  b.attach([:c_12])
end

circle({ id: :c_123, color: :cyan, left: 233, drag: true })
b1 = box({ id: :b_1, left: 333, drag: true })
grab(:b_1).attach([:c_123])
# alert ("0 - #{b1.id}")
# alert "1 - #{grab(:b1).inspect}"
# wait 2 do
#   # circle_123_color= grab(:c_123)
#   # alert(circle_123_color)
#   # circle_123_color.attached([:b_1])
#   # alert "2 - #{grab(:b1).inspect}"
#   # grab(:b1).attached(:c_123)
# end

#
bb = box({ top: 99, drag: true })
bb.attach([:b_1])

# wait 1 do
#   grab(:c315).attach([:c_12])
# end

box({ id: :my_test_box })

alert grab(:b_1).inspect