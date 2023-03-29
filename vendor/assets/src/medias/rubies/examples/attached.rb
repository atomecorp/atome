# frozen_string_literal: true
grab(:user_view).color({ red: 1, green: 0.6, blue: 0.6, id: :active_color })
grab(:user_view).color( { red: 0.3, green:  0.3, blue: 0.3, id: :inactive_color } )

b=box({left: 99})
wait 1 do
  b.attached([:active_color])

puts b.attached
end
puts b.attached
c=circle({left: 333})
c.attached(:inactive_color)


