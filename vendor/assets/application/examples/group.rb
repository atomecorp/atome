# frozen_string_literal: true

text({ data: 'hello for al the people in front of their machine jhgj  jg jgh jhg  iuuy res ', center: true, top: 120, width: 77, component: { size: 11 } })
box({ left: 12 })
the_circle = circle({ id: :cc, color: :yellowgreen, top: 222 })
the_circle.image('red_planet')
the_circle.color('red')
the_circle.box({ left: 333, id: :the_c })

element({ id: :the_element })

the_view = grab(:view)

color({ id: :the_orange, red: 1, green: 0.4 })

the_group = group({ collected: the_view.shape })
wait 2 do
  the_group.left(633)
  wait 2 do
    the_group.rotate(23)
    wait 2 do
      the_group.apply([:the_orange])
      the_group.blur(6)
    end
  end
end
puts the_group.collected
