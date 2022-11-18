# frozen_string_literal: true

b = box({ width: 333, left: 333})
b.height(33)
b.left(333)

b.smooth([33, 2, 90])
b.touch(true) do

  color({ render: [:html], id: "color_#{Universe.atomes.length}", type: :color,
          red: 1, green: 0.33, blue: 0.22, alpha: 1 })
end
 b.circle({ left: 333 })