# frozen_string_literal: true

b = box({ id: :mybox, width: 666, height: 555, top: 0, left: 0 })

c = b.circle()
t = c.text({ data: :hello, visual: { size: 9 } })
c.color(:red)
wait 2 do
  c.center(true)
  t.center(true)
end

wait 4 do
  c.center(:horizontal)
  t.center(:horizontal)
end

wait 6 do
  c.center(:vertical)
  t.center(:vertical)
end
