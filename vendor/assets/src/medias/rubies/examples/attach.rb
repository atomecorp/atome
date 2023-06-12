# frozen_string_literal: true

b=box({id: :c315})
circle({id: :c_12, top: 0,drag: true})
b.attach([:c_12])

circle({ id: :c_123, color: :cyan, left: 233, drag: true })
box({ id: :b_1, left: 333, drag: true })
grab(:b_1).attach([:c_123])

wait 2 do
  circle_123_color= grab(:c_123).color
  circle_123_color.attach([:b_1])
end



bb=box({top: 99, drag: true})
bb.attach([:b_1])
grab(:c315).attach([:c_12])
