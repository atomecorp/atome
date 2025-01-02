# # frozen_string_literal: true

b=box({ left: 12, id: :the_first_box })
color({ id: :the_lemon, red: 1, green: 1 })
wait 1 do
  b.apply(:the_lemon)
end

