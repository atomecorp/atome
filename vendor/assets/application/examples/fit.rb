# frozen_string_literal: true

c = circle({ height: 400, width: 200, top: 100, left: 0, top: 100 })
b = c.box({ width: 200, height: 100, left: 600, top: 200, id: :my_box })
c.circle({ width: 200, height: 100, left: 120, top: -80, id: :my_text, data: :hi })
b.circle({ color: :yellow, width: 55, height: 88, left: 100 })
b.box

wait 1 do

  c.fit({ value: 100, axis: :x })

  wait 1 do
    c.fit({ value: 66, axis: :y })
    wait 1 do
      c.fit({ value: 200, axis: :x })
    end
  end
end




