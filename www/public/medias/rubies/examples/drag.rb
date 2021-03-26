# drag

b=box
b.drag(true) do |evt|
  b.rotate(evt.page_x)
end