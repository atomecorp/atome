# frozen_string_literal: true

b = box({ left: 155, drag: true, id: :boxy })

t=b.text({ data: :hello, id: :t1, position: :absolute, color: :black })
t2 = b.text({ data: :hello, id: :t2, left: 9, top: 33, position: :absolute })


wait 1 do
  grab(:view).retrieve do |child|
    child.color(:blue)
  end
end

wait 2 do
  parent = grab(:view)
  grab(:view).retrieve(:inverted) do |child|
    child.delete(true)
  end
end
