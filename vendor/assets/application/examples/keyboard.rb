#  frozen_string_literal: true

t = text :hello
t.left(99)

t.edit(true)

t.keyboard(:press) do |native_event|
  event = Native(native_event)
  puts "====>#{event[:key]} :  #{event[:keyCode]}"
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
  puts event[:keyCode]
  puts event[:key]

end

t.keyboard(:input) do |native_event|
  event = Native(native_event)
  puts event
end

t.keyboard(:keydown) do |native_event|
  event = Native(native_event)
  puts "down : #{event[:keyCode]}"
end

wait 4.5 do
  puts '------ :not editable: ------'
  t.edit(false)
end

wait 3 do
  puts '------ :stopped: ------'
  text({data:  'stop editing', top: 150 })
  t.keyboard(:kill)
end
