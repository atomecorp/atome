# frozen_string_literal: true

box({ left: 12, id: :the_first_box })
c=color({ id: :the_bananas, blue: 0.21, green: 1 })

wait 1 do
  c.affect(:the_first_box)
end
