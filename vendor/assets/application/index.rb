# frozen_string_literal: true

# uncomment below for a fast example

# b=box({id: :my_box})
# wait 1 do
#   b.left(369)
#   b.top(368)
#   grab(:my_box).color(:red)
#   grab(:my_box).smooth(6)
# end
# # open the console in your browser ou your native app and should see the text below
# puts "hello world"
#
# require "./examples/blur"
# require "./examples/browser"



# #########
# #{BROWSER: {open: true, execute: true}}
# puts 'start'
# c = circle({ left: 444 })
# b = box({ left: 120, top: 120, color: :orange, id: :the_box })
#
# b.touch(:down) do
#   puts 'touched'
#   b.width(333)
#   b.color(:yellow)
#   c.width(333)
# end
# # wait 1 do
# #   b.height(333)
# #   b.color(:blue)
# # end
# puts 'end'
#
#
#
# wait 1 do
#   reenact(:the_box, :touch)
# end
