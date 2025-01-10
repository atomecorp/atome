# frozen_string_literal: true
grab(:black_matter).color({ red: 1, green: 0.6, blue: 0.6, id: :active_color })
grab(:black_matter).color( { red: 0.3, green:  1, blue: 0.3, id: :inactive_color } )

b=box({left: 99, drag: true})
wait 1 do
  b.fasten([:active_color])

puts b.fasten
end
puts b.fasten
c=circle({left: 333})
wait 2 do
  c.fasten(:inactive_color)
  c.attach(b.id)
end
