# frozen_string_literal: true

allow_right_touch(true)
wait 3 do
  allow_right_touch(false)
end
wait 6 do
  allow_right_touch(true)
end

wait 9 do
  allow_right_touch(false)
end

wait 12 do
  allow_right_touch(true)
end