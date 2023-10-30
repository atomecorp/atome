# frozen_string_literal: true

b = box({ top: 166 })
b.color(:red)
new({ particle: :remove }) do |params|
  apply.delete(params)
  refresh
end

wait 1 do
  b.color(:yellow)
  wait 1 do
    b.remove(:box_color)
  end
end
