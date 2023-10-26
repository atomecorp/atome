# frozen_string_literal: true

b = box
circle({ left: 222 })
wait 2 do
  grab(:view).clear(true)
end