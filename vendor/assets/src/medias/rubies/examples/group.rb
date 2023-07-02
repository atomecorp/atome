# frozen_string_literal: true
# Group demo

box({ id: :b0, color: :black, drag: true })
box({ id: :b2, left: 220, drag: true, color: :red })
box({ id: :b1, left: 340 })
g = group([:b1, :b2])

wait 3 do
  g.color(:violet)
end

wait 2 do
  g.top(0)
  wait 2 do
    g.attach([:b0])
    g.blur(33).rotate(44)

  end
end


# b=box
#
# # b.text(:red)
# b.drag(true)
# wait 2 do
#   b.color
#   # grab(:text_14).color(:red)
#   b.image
# end
