b=box
b.drag(true) do |x, y|
  # below here is the callback :
  puts "drag position: #{x}"
end