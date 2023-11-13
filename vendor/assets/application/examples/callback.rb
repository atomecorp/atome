#  frozen_string_literal: true


# here is how callbock is used with atome
test_box = box({left: -20})

test_box.blur(9) do |params_back|
  puts "here is the callback  : #{params_back}"
end
# per example it's possible to set back params like this
test_box.callback({ blur: 'I am the callback content!!' })
# now we call the callback for blur
test_box.call(:blur)

circle({id: :the_c})
# here is a callback with event params
test_box.drag(true) do |event|
  grab(:the_c).left(150+event[:pageX].to_i)
end

