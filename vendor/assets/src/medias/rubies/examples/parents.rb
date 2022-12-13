# frozen_string_literal: true

b=box({id: :c315})
circle({id: :circle_12, top: 0,drag: true})

b.parents([:circle_12])

circle({ id: :circle_123, color: :cyan, left: 233, drag: true })
box({ id: :box_1, left: 333 })
bb=box({top: 99})
grab(:box_1).parents([:circle_123])
grab(:color_circle_123).parents([:box_1])
#
bb.parents([:box_1])
grab(:c315).parents([:circle_12])
