# frozen_string_literal: true

b = box({left: 333 })
wait 1 do
  b.width(33)
end