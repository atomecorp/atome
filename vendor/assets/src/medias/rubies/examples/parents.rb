# frozen_string_literal: true

b=box({id: :c315})
circle({id: :circle_12, top: 0,drag: true})

b.attach([:circle_12])

circle({ id: :circle_123, color: :cyan, left: 233, drag: true })
box({ id: :box_1, left: 333 })
bb=box({top: 99})
grab(:box_1).attach([:circle_123])
circle_123_color= grab(:circle_123).color[0]
grab(circle_123_color).attach([:box_1])
bb.attach([:box_1])
grab(:c315).attach([:circle_12])
