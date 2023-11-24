# frozen_string_literal: true

m = shape({ id: :the_shape, width: 333, left: 130, top: 30, right: 100, height: 399, smooth: 8, color: :yellowgreen, })
m.drag(true)
m.on(:resize) do |event|
  puts event[:dx]
end

m.resize({ size: { min: { width: 90, height: 190 }, max: { width: 300, height: 600 } } }) do |event|
  puts "width is  is #{event[:rect][:width]}"
end

t=text({data: ' click me to unbind resize'})
t.touch(true) do
  t.data('resize unbinded')
  m.resize(:remove)
end