#  frozen_string_literal: true

test_box = box()

test_box.blur(9) do |params_back|
  puts "here is the callback #{params_back}"
end
# per example it's possible to set back params like this
test_box.callback({ blur: :my_data })
# now we call the callback for blur
test_box.call(:blur)

