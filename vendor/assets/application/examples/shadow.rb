# frozen_string_literal: true

# TODO : ATTENTION if id is not specified for the shadow it wont create a new one
c = circle({ id: :the_circle, left: 122, drag: { move: true, inertia: true, lock: :start } })
c.color({ id: :col1, red: 1, blue: 1 })
c.color({ id: :col2, red: 0, blue: 1, green: 0.3 })
c.color(:yellowgreen)
# c2 = circle({ id: :the_circle2, left: 222, drag: { move: true, inertia: true, lock: :start } })
# c2.color(:red)
# c3 = circle({ id: :the_circle3, left: 322, drag: { move: true, inertia: true, lock: :start } })
# c3.color(:yellow)

c.shadow({
           id: :s1,
           affect: [:the_circle],
           left: 9, top: 3, blur: 9,
           invert: false,
           red: 0, green: 0, blue: 0, alpha: 1
         })

c.shadow({
           id: :s2,
           affect: [:the_circle],
           left: 3, top: 9, blur: 9,
           invert: true,
           red: 0, green: 0, blue: 0, alpha: 1
         })
c.shadow({
           id: :s3,
           affect: [:the_circle],
           left: -3, top: -3, blur: 9,
           invert: true,
           red: 0, green: 0, blue: 0, alpha: 1
         })
#
# c2.shadow({
#             id: :s3,
#             affect: [:the_circle2],
#             left: 9, top: 9, blur: 9,
#             option: :natural,
#             red: 0, green: 0, blue: 0, alpha: 1
#           })
#
# c3.shadow({
#             id: :s4,
#             affect: [:the_circle3],
#             left: 3, top: 3, blur: 9,
#             red: 0, green: 0, blue: 0, alpha: 1
#           })

