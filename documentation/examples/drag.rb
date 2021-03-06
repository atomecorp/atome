# drag

b=box
b.drag(true) do |evt|
  b.rotation(evt.page_x)
end

