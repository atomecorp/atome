# frozen_string_literal: true

puts "Attention this method only work with a server due to security restriction "
a=box
text("touch the box to read the file")
a.touch(true) do
  a.read('rubies/examples/image.rb') do |params|
    text({data: params, visual:{size: 9}})
  end
end

