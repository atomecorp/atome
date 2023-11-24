# # frozen_string_literal: true
b=box({ left: 12, id: :the_first_box })
#
color({ id: :the_lemon, red: 0, blue: 1 })
color({ id: :the_lemon, red: 0, blue: 1 })
grab(:view).color(:red)
wait 1 do
b.apply([:the_lemon])
end
