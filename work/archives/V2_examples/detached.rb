# frozen_string_literal: true
# Detached
grab(:black_matter).color( { red: 1, green:  1, blue: 0.3, id: :inactive_color } )
grab(:black_matter).color({ red: 0.8, green: 0.3, blue: 0.8, id: :active_color })
b=shape({id: :the_shape, drag: true, left: 200})


t=b.text({id: :the_text,data:  'click me!' })
b.circle({id: :the_circle})
# alert t
# alert b
wait 2 do
  t.fasten(:inactive_color)
end

b.touch(true) do

  t.detached(:inactive_color)
  wait 2 do
    t.fasten(:active_color)
  end
  puts "detached objects are : #{t}"
end



# b.fasten(c.id)

# wait 2 do
#   b=shape({id: :the_shape, drag: true, left: 200})
#   t=b.text(:hello)
#   t.color(:red)
#   # b.circle
# end