# frozen_string_literal: true
label = text({ data: 0, top: 400, left: 69, component: { size: 12 }, color: :gray })

grab(:intuition).slider({ id: :toto, range: { color: :white }, min: -12, max: 33, width: 333, value: 12, height: 25, left: 99, top: 350, color: :red, cursor: { color: :red, width: 25, height: 25 } }) do |value|
  label.data("(#{value})")
end

aa = grab(:intuition).slider({ orientation: :vertical, range: { color: :orange }, value: 55, width: 55, height: 555, attach: :intuition, left: 555, top: 33, color: :orange, cursor: { color: :orange, width: 33, height: 66, smooth: 3 } }) do |value|
  label.data("(#{value})")
end

wait 2 do
  aa.holder.value(33)
end
