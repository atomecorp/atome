#  frozen_string_literal: true

test_box = box()
test_box.blur(9) do |params_back|
  puts "here is the callback #{params_back}"
end

test_box.callback(:blur)

# if you want to overide default callback method:
# you can overide the default method like this
new({ callback: :blur }) do
  # TODO : change the context to avoid test_box.terminal
  puts "this is a message from the custom callback method #{test_box.left}"
end

test_box.callback(:blur)
