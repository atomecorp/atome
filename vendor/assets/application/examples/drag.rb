#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })

clone = ""
b.drag(:start) do
  b.color(:black)
  b.height(123)
  clone = box({ id: "#{b.id}_cloned", left: b.left, top: b.top })
end

b.drag(:stop) do
  b.color(:white)
  b.height(12)
  clone.delete(true)

end

b.drag(:lock) do |native_event|
  event = Native(native_event)
  dx = event[:dx]
  dy = event[:dy]
  x = (clone.left || 0) + dx.to_f
  y = (clone.top || 0) + dy.to_f
  clone.left(x)
  clone.top(y)
end

