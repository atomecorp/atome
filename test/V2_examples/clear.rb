# frozen_string_literal: true

box(id: :my_box)

circle(left: 333)

wait 2 do
  grab(:view).clear(true)
end

