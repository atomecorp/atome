# drag

b=box({y: 200})
b.drag(true) do |evt|
  b.rotate(evt.page_x)
end