# # frozen_string_literal: true
b=box({ left: 12, id: :the_first_box })
#
color({ id: :the_lemon, red: 1, green: 1 })
c=color({ id: :the_bananas, blue: 0.21, green: 1 })
grab(:view).color(:red)
wait 1 do
  b.apply(:the_lemon)
end

wait 2 do
  c.affect(:the_first_box)
end
