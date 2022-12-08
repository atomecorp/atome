# frozen_string_literal: true

puts "Attention this method only work with a server due to security restriction "
# a = element(data: :hello_world)
a=box

a.read('rubies/examples/image.rb') do |params|
  text({data: params, visual:{size: 9}})
end