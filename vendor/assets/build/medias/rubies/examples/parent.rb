b=box({id: :c315})
circle({id: :circle_12})
grab(:c315).parent([:circle_12])
b.parent([:circle_12])


circle({ id: :circle_123, color: :cyan })
box({ id: :box_1, left: 333 })
bb=box({top: 99})
grab(:box_1).parent(:circle_123)
grab(:color_circle_123).parent([:box_1])

bb.parent([:box_1])