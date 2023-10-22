# frozen_string_literal: true
new({ particle: :invert })
new({ particle: :option })

c = circle({ id: :the_circle, left: 122, drag: { move: true, inertia: true, lock: :start } })
c.color(:orange)
c2 = circle({ id: :the_circle2, left: 222, drag: { move: true, inertia: true, lock: :start } })
c2.color(:red)
c3 = circle({ id: :the_circle3, left: 322, drag: { move: true, inertia: true, lock: :start } })
c3.color(:yellow)


c.shadow({
           # renderers: [:html], id: :shadow2,
           type: :shadow,
           affect: [:the_circle],
           left: 9, top: 9, blur: 9,
           invert: true,
           red: 0, green: 0, blue: 0, alpha: 1
         })

c2.shadow({
           # renderers: [:html], id: :shadow2,
           type: :shadow,
           affect: [:the_circle2],
           left: 9, top: 9, blur: 9,
           option: :natural,
           red: 0, green: 0, blue: 0, alpha: 1
         })

c3.shadow({
            # renderers: [:html], id: :shadow2,
            type: :shadow,
            affect: [:the_circle3],
            left: 3, top: 3, blur: 9,
            red: 0, green: 0, blue: 0, alpha: 1
          })

