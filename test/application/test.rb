# b = box
# b.drag(true) do |e|
#   # puts e
#   puts "short"
# end
# #
# b.drag(:start) do |e|
#   # puts e
#   puts "short"
# end
# b.drag(:end) do |e|
#   # puts e
#   puts "short"
# end
# b.drag({ option: :start }) do |e|
#   # puts e
#   puts "short2"
# end
# b.drag({ option: :drag }) do |e|
#   # puts e
#   puts "drag2"
# end
#
# b.drag({ option: :end }) do |e|
#   # puts e
#   puts "end2"
# end
#
# b.touch(true) do |e|
#   # puts e
#   alert "long"
# end
#
# b.touch(:long) do |e|
#   # puts e
#   alert "long"
# end
#
# b.over(true) do |e|
#   # puts e
#   puts "true"
# end
# b.over({ option: :enter }) do |e|
#   # puts e
#   puts "enter"
# end
# b.over(:enter) do |e|
#   # puts e
#   puts "enter 2"
# end
#
# b.over(:leave) do |e|
#   puts "leave"
# end
#
#   t = text(:deert)
#   t.data(true) do |e|
#     puts 'ok '
#   end
# t.color(:red)
# t.data_code[:data].call
# # end
#
# puts '------ end -----'
# puts "inspect : #{b.inspect}"
# puts '------'
# wait 3 do
#   alert "drag : #{b.drag}"
#   alert "instance drag : #{b.instance_variable_get("@drag")}"
#   alert "===> drag_code : #{b.drag_code}"
# end
# # alert "b.inspect : #{b.inspect}"
#
# # alert "b.touch : #{b.touch}"
# # alert b.touch_code
# # alert t.data_code
# # ############## to check
# # alert Universe.user_atomes.length
# # puts '----------'
# # t = text({ data: :hello1, component: { size: 66 }, left: 0 })
# # t = text({ data: :hello1, component: { size: 66 }, left: 0 })
# # alert Universe.atomes.length
# # t=text({ data: :hello1,component: { size: 66 },left: 0 })
# # alert Universe.user_atomes.length
# # # alert t.id
# # wait 1 do
# #   t2=text({ data: [:hello],component: { size: 66 },left: 120 })
# #   # alert t2.id
# # end
# # b=box
# # # alert b.id
# # b2=box
# # # alert b2.id
# #
t = text({ data: 'hello for al the people in front of their machine jhgj  jg jgh jhg  iuuy res (', center: true, top: 120, width: 77, component: { size: 11 } })
box
puts '--------------------***--------------------'
alert grab(:view).shape
wait 2 do
  t.delete(true)
end
# shape()