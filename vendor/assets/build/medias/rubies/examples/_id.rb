# frozen_string_literal: true

b = box({ id: :my_box })
b.color(:orange)

b.id(:the_new_id)

wait 1 do
  b.color(:blue)
end

wait 2 do
  grab(:the_new_id).color(:cyan)
end