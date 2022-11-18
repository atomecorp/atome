# frozen_string_literal: true

b = box

wait 1 do
  b.delete(true)
end