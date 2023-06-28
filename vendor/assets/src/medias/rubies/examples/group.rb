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
    g.blur(33)

  end
end




# b=box({ id: :b1 })
# b.box({ id: :b2, left: 220 })
# b.box({ id: :b3, left: 340 })
# grouped_object=group([:b2, :b3])
# # alert grouped_object.type
# wait 2 do
#   grouped_object.color({id: :the_col, renderers: [:browser], blue: 1})
# end
# wait 3 do
#   grouped_object.width(33)
#   # grouped_object.left(3)
#   # grouped_object.text(:hello)
#   grouped_object.color(:violet)
# end