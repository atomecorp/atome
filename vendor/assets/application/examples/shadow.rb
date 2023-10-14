# frozen_string_literal: true

c = circle({ id: :the_circle, left: 222, drag: { move: true, inertia: true, lock: :start } })
c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow,
           affect: [:the_circle],
           left: 3, top: 9, blur: 19,
           red: 0, green: 0, blue: 0, alpha: 1
         })
