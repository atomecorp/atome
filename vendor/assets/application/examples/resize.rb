# frozen_string_literal: true

m = shape({ id: :the_shape, width: 333, left: 130, top: 30, right: 100, height: 399, smooth: 8, color: :yellowgreen, })
# m=text({data: :hello, edit: true})
m.drag(true)
m.on(:resize) do |event|
  puts event[:dx]
end
m.resize(true) do |event|
  puts event
end