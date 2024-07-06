# frozen_string_literal: true

b = box({ left: 155, drag: true, id: :boxy })

t=b.text({ data: :hello, id: :t1, position: :absolute, color: :black })
t2 = b.text({ data: :hello, id: :t2, left: 9, top: 33, position: :absolute })


wait 1 do
  grab(:view).retrieve do |child|
    child.left(33)
  end
  wait 1 do
    grab(:boxy).retrieve do |child|
      child.color(:green)
    end
    wait 1 do
      grab(:view).retrieve({ ascending: false, self: false }) do |child|
        child.delete(true)
      end
    end
  end
end

