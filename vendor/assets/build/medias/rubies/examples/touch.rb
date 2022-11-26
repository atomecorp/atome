# frozen_string_literal: true

b = box({ width: 333, left: 666})

b.touch(true) do
  color({ render: [:html], id: "color_#{Universe.atomes.length}", type: :color,
          red: 1, green: 0.33, blue: 0.22, alpha: 1 })
end

text.touch(true) do
  color(:yellow)
  box
end