#  frozen_string_literal: true

# require './examples/login'
# https://github.com/travist/jsencrypt

# TODO : debug code below:

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
#
b.touch(true) do |e|
  puts 'ok'
end
b.touch({ :long => true }) do
  puts 'ok kool'
end

# b.touch(:long) do
#     b.color(:cyan)
#   end
# alert b.touch

# alert b.touch

# b.touch(true) do
#   alert :kool
# end
#
# wait 2 do
#   b.clones([ { left: 222 }])
# end

# TODO: check that atome gem build correctly the solution
# TODO: change atomic repository so that it install atome gem correctly
# TODO : add onscroll event
# TODO : find a way to unbind a specific event

# frozen_string_literal: true
#
# separator=120
# b=box({ left: separator, id: :test_box })
# # c=box({ left: b.left+separator })
# # d=box({ left: c.left+separator })
# # e=box({ left: d.left+separator })
# #
# b.touch(:down) do
#   b.color(:red)
#   # c.color(:red)
#   # d.color(:red)
#   # e.color(:red)
# end
# # # b.text({data: :down})
# #
# # c.touch(:long) do
# #   b.color(:blue)
# #   c.color(:blue)
# #   d.color(:blue)
# #   e.color(:blue)
# # end
# # # c.text({data: :long})
# #
# # d.touch(:double) do
# #   b.color(:yellow)
# #   c.color(:yellow)
# #   d.color(:yellow)
# #   e.color(:yellow)
# # end
# # # d.text({data: :up})
# # e.touch(:up) do
# #   b.color(:black)
# #   c.color(:black)
# #   d.color(:black)
# #   e.color(:black)
# # end
# # e.text({data: :double})
#
# # ccc=circle
# # ccc.top(199)
# #
# # # def unbind(val=nil)
# # #   id_found=self.atome[:id]
# # # `
# # # const el = document.getElementById(#{id_found});
# # # interact('#'+#{id_found}).unset(#{val});
# # # `
# # # end
# b.touch(:long) do
#   b.color(:cyan)
# end
# # alert "b touch is : #{b.touch}"
# # ccc.touch(true) do
# #   b.unbind(:tap)
# #   alert b.touch
# # end

