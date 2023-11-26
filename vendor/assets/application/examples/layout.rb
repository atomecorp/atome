# frozen_string_literal: true
b = box
50.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45) })
end