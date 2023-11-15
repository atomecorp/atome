# frozen_string_literal: true

m = shape({ id: :the_shape, width: 333, left: 130, top: 30, right: 100, height: 399, smooth: 8, color: :yellowgreen, })
m.drag(true)
m.on(:resize) do |event|
  puts event[:dx]
end
m.resize({ size: { min: { width: 10, height: 10 }, max: { width: 300, height: 600 } } }) do |event|
  puts "event is #{event}"
end

t=text({data: :unbind})
t.touch(true) do
  m.resize(:remove)
end