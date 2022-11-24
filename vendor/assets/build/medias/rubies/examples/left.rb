# frozen_string_literal: true

b = box({left: 333 })

wait 1 do
  b.left(33)
end
