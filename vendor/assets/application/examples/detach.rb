#  frozen_string_literal: true

b = box({ drag: true, id: :the_b })
c = b.circle({ left: 99, id: :the_c })
d = b.text({ data: :hello, left: 44, top: 44, id: :the_t })
c.touch(:down) do
  c.detach(b.id)
end