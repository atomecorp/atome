# drag

b=box({y: 200})
b.drag(true) do |evt|
  b.rotate(evt.page_x)
end
dragger=box({width: 96, height: 96})
handle=dragger.box({width: 96, height: 16, color: :orange, atome_id: :the_handle})
handle.text({content: "drag me from here", size: 12, color: :black})
dragger.drag({handle: :the_handle})
circle({y:111, drag:{lock: :y}})