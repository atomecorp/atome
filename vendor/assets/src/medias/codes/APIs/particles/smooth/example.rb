# frozen_string_literal: true

b = box({ width: 333, left: 333 })
b.smooth(9)

wait 2 do
  b.smooth([33, 2, 90])
end

