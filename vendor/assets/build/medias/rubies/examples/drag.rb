b = box

b.drag({ lock: :x }) do |position|
  # below here is the callback :
  puts "callback drag position: #{position}"
  puts "callback id is: #{id}"

end
