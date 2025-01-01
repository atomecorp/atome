# frozen_string_literal: true

c = circle({ height: 400, width: 200, top: 100, left: 0, top: 100 })
b = c.box({ width: 200, height: 100, left: 600, top: 200, id: :my_box })
c.circle({ width: 200, height: 100, left: 120, top: -80, id: :my_text, data: :hi })
b.circle({ color: :yellow, width: 55, height: 88, left: 100 })
b.box
i=c.image({path: 'medias/images/red_planet.png', id: :the_pix })
# b.text(:red_planet)

wait 1 do

  c.fit({ value: 100, axis: :x })

  wait 1 do
    c.fit({ value: 66, axis: :y })
    wait 1 do
      c.fit({ value: 600, axis: :x })
    end
  end
end
# alert i.width
# alert i.height
# i.fit({ value: 66, axis: :x })
#  i.width(66)
#  i.height(66)
