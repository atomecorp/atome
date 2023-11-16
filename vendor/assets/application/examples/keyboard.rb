#  frozen_string_literal: true

t = text :hello
t.left(99)

t.edit(true)

t.keyboard(:press) do |native_event|
  event = Native(native_event)
  puts "press : #{event[:key]} :  #{event[:keyCode]}"
end

t.keyboard(:down) do |native_event|
  event = Native(native_event)
  if event[:keyCode].to_s == '13'
    event.preventDefault()
    t.color(:red)
  end

end

t.keyboard(:up) do |native_event|
  event = Native(native_event)
  puts "up!!"
end

t.keyboard(true) do |native_event|
  event = Native(native_event)
  puts " true => #{event[:keyCode]}"
  puts "true => #{event[:key]}"

end

# t.keyboard(:input) do |native_event|
#   event = Native(native_event)
#   puts event
# end

# t.keyboard(:keydown) do |native_event|
#   event = Native(native_event)
#   puts "down : #{event[:keyCode]}"
# end

c = circle({ top: 123, left: 0, width: 55, height: 55 })
c2 = circle({ top: 123, left: 80, width: 55, height: 55 })
c3 = circle({ top: 123, left: 150, width: 55, height: 55 })

c.touch(true) do
  text({ data: 'stop up', top: 150 })
  t.keyboard({ remove: :up })
end
c2.touch(true) do
  text({ data: 'remove all', top: 150 })
  t.keyboard(:remove)
end
c3.touch(true) do
  t.edit(false)
  text({ data: 'stop editing', top: 150 })
end
