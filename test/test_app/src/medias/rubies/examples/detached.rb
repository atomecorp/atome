# frozen_string_literal: true

grab(:user_view).color({ red: 0.8, green: 0.8, blue: 0.8, id: :active_color })
grab(:user_view).color( { red: 0.3, green:  0.3, blue: 0.3, id: :inactive_color } )

b=box
b.attached(:inactive_color)
puts b.attached
b.touch(true) do
  b.detached(:inactive_color)
  b.attached(:active_color)
  puts "detached objects are : #{b.attached}"
end