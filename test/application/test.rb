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
# ############## ##################### to check
# alert Universe.user_atomes.length
# puts '----------'
# t = text({ data: :hello1, component: { size: 66 }, left: 0 })
# t = text({ data: :hello1, component: { size: 66 }, left: 0 })
# alert Universe.atomes.length
# t=text({ data: :hello1,component: { size: 66 },left: 0 })
# alert Universe.user_atomes.length
# # alert t.id
# wait 1 do
#   t2=text({ data: [:hello],component: { size: 66 },left: 120 })
#   # alert t2.id
# end
# b=box
# # alert b.id
# b2=box
# # alert b2.id
# ########################
# Test temp below

# t = text({ data: 'hello for al the people in front of their machine jhgj  jg jgh jhg  iuuy res ', center: true, top: 120, width: 77, component: { size: 11 } })
# box
# cc = circle({ id: :cc })
#
# element({ id: :jj })
# toto = grab(:view)
# puts "toto's shape are : #{toto.shape}"
# group({ data: toto.shape })
#
# wait 1 do
#   cc.left = 633
#   t.delete(true)
# end
# # shape()
######## WWW
# video(:video_missing)
#
# image(:red_planet)
#
# the_one = circle(markup: :h1)
#
# text(:hello)
# wait 3 do
#   the_one.markup(:div)
# end
# c=circle
# c.www({ path: "https://www.youtube.com/embed/usQDazZKWAk", left: 333 })
# Atome.new(
#   renderers: [:html], id: :youtube1, type: :www, attach: [:view], path: "https://www.youtube.com/embed/fjJOyfQCMvc?si=lPTz18xXqIfd_3Ql", left: 33, top: 33, width: 199, height: 199,
#
# )

###### raw

raw_data = <<STR
<iframe width="560" height="315" src="https://www.youtube.com/embed/8BT4Q3UtO6Q?si=WI8RlryV8HW9Y0nz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
STR
b = box({ id: :boxy })
b.raw({ id: :the_raw_stuff, data: raw_data })
# b.www({ path: "https://www.youtube.com/embed/usQDazZKWAk", left: 333 })
# b.circle({id: :circly})
# a = b.shape(
#   { renderers: [:html], id: :my_test_box, type: :shape,  apply: [:shape_color],
#     left: 120, top: 0, width: 100,smooth: 333, height: 100, overflow: :visible, attached: [], color: :white
#   })

