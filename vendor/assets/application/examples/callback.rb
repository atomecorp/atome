#  frozen_string_literal: true

test_box = box()
test_box.blur(9) do |params_back|
  puts "here is the callback #{params_back}"
end

test_box.callback(:blur)
