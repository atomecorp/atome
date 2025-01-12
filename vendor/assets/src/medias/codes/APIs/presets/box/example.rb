#{BROWSER: {open: true, execute: true}}
puts 'start'
b=box({left: 120, top: 120, color: :orange, id: :the_box})

b.touch(true) do
  puts 'touched'
  b.width(333)
  b.color(:blue)
end
# wait 1 do
#   b.height(333)
#   b.color(:blue)
# end
puts 'end'
