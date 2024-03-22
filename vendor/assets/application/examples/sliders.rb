# frozen_string_literal: true

label = text({ data: 0, top: 400, left: 69, component: { size: 12 }, color: :gray })

aaa = grab(:intuition).slider({ id: :toto, range: { color: :yellow }, min: -12, max: 33, width: 333, value: 12, height: 25, left: 99, top: 350, color: :orange, cursor: { color: :orange, width: 25, height: 25 } }) do |value|
  label.data("(#{value})")
end

aa = grab(:intuition).slider({ orientation: :vertical, range: { color: :white }, value: 55, width: 55, height: 555, attach: :intuition, left: 555, top: 33, color: :red, cursor: { color: {alpha: 1, red: 0.12, green: 0.12, blue: 0.12}, width: 33, height: 66, smooth: 3 } }) do |value|
  label.data("(#{value})")
end

b=box
b.touch(true) do
  aa.value(12)
  aaa.value(-6)
end
