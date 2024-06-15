#  frozen_string_literal: true


b = box({ drag: true, id: :the_b })
c = b.circle({ left: 99, id: :the_c })
t = b.text({ data: :hello, left: 44, top: 44, id: :the_t })
c.touch(:down) do
  b.unfasten([c.id])
  b.color(:green)
  t.data('circle unfasten')
  wait 3 do
    b.color(:red)
    t.data('unfasten all attached atomes')
    b.unfasten(:all)
  end

end