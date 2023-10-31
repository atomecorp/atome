# frozen_string_literal: true

b = box({ id: :c315 })
circle({ id: :c_12, top: 0, drag: true })
wait 1 do
  b.attach([:c_12])
end

circle({ id: :c_123, color: :cyan, left: 233, drag: true })
 box({ id: :b_1, left: 333, drag: true })
grab(:b_1).attach([:c_123])

bb = box({ top: 99, drag: true })
bb.attach([:b_1])


box({ id: :my_test_box })

