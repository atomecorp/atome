# frozen_string_literal: true


box({id: :my_box})
circle({id: :my_circle, left: 333})
box({id: :red_box, left: 666, color: :red})



shortcut(key: :b,  affect: :all) do |key, object_id|
  puts "Key #{key} press on #{object_id}"
end
text({data: "Key 'b'  on :all", top: 0})

shortcut(key: :t, option: :meta,affect: [:my_circle, :red_box]) do |key, object_id|
  puts "Key #{key}  press on #{object_id}"
end
text({data: "Key 't' with Meta  on [:my_circle, :red_box]", top: 30, left: 0, position: :absolute})


shortcut(key: :j, option: :ctrl, affect: :all, exclude: [:my_circle, :my_box]) do |key, object_id|
  puts "Key #{key} with Ctrl press on #{object_id}"
end
text({data: "Key 'j' with Ctrl  on :all but [:my_circle, :my_box]", top: 50,left: 0, position: :absolute})

