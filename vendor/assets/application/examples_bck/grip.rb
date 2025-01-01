# frozen_string_literal: true

b=box
b.circle({role: :header, left: 55, id: :first_one})
b.text({role: [:action], data: "hello", top: 90})
b.box({role: :header, left: 155, id: :second_one})


puts"header grip : #{ b.grip(:header)}"
puts "last header grip #{b.grip(:header).last}"
