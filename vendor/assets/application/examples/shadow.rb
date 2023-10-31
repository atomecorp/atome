# frozen_string_literal: true

c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })
 c.color({ id: :col1, red: 1, blue: 1 })

 c.shadow({
              id: :s1,
              # affect: [:the_circle],
              left: 9, top: 3, blur: 9,
              invert: false,
              red: 0, green: 0, blue: 0, alpha: 1
            })

shadow({
           id: :s2,
           affect: [:the_circle],
           left: 3, top: 9, blur: 9,
           invert: true,
           red: 0, green: 0, blue: 0, alpha: 1
         })

c.shadow({
           id: :s4,
           left: 20, top: 0, blur: 9,
           option: :natural,
           red: 0, green: 1, blue: 0, alpha: 1
         })





