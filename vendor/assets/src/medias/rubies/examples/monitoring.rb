# frozen_string_literal: true
bb=text({data: :hello })
#
bb.touch(true) do
  bb.left(333)
end

# alert grab(:view).attached
bb.monitor({ atomes: grab(:view).attached, particles: [:left] }) do |_atome, _element, value|
  puts "the left value of #{id} was change to : #{value}"
end

a = text({ data: "open the console!" })
a.right(44).left(66)
color({red: 1, id: :the_red_col})
b = Atome.new(shape: { type: :shape, id: :my_shape, attach: [:view], renderers: [:browser],
                       left: 0, right: 33, attached: :the_red_col, width: 33, height: 33
})

c = Atome.new(shape: { type: :shape, id: :my_pix,  attach: [:view], renderers: [:browser],
                       left: 50, right: 78, attached: :the_red_col, width: 33, height: 33
})




b.left(936)
wait 0.5 do
  b.left(777)
  wait 0.5 do
    c.left(888)
  end
end

puts "bb monitor is #{bb.monitor}"

# test 2
aa = text({ data: 'touch me and look in the console', top: 99, width: 399, left: 120 })


bb=box({ id: :the_boxy })

aa.touch(true) do
  aa.color(:red)
  aa.left(333)
  aa.width(555)
  aa.right(4)
  aa.height(199)
end
bb.drag(true)
bb.monitor({ atomes: grab(:view).attached, particles: [:left] }) do |_atome, _element, value|
  puts "the left value of #{id} was change to : #{value}"
end

bb.monitor({ atomes: grab(:view).attached, particles: [:top] }) do |_atome, _element, value|
  puts "the top value of #{id} was change to : #{value}"
end

bb.monitor({ atomes: grab(:view).attached, particles: [:width] }) do |_atome, _element, value|
  puts "the width's value of #{id} was change to : #{value}"
end

bb.monitor({ atomes: grab(:view).attached, particles: [:left], id: :my_monitorer }) do |_atome, _element, value|
  puts "the second monitor left value of #{id} was log to : #{value}"
end
# puts aa.monitor
bb.top(66)
a.monitor({ atomes: grab(:view).attached, particles: [:left] }) do |atome, element, value|
  puts "monitoring  #{id} : #{atome.id}, #{element}, #{value}"
end