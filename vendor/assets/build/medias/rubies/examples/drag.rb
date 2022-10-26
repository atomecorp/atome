b=box
b.drag(true) do |position|
  # below here is the callback :
  puts "drag position: #{position}"
  puts "id is: #{id}"
end