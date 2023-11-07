#  frozen_string_literal: true



b = box({ id: :the_box, left: 66,password: :toto,
          security: {
            smooth: {
              write: { password: :other_pass },
              read: { password: :read_pass }
            }
          }
        })
puts '----'

# authorise has two params the first is the password to authorise the second is used to destroy the password or keep for
# further alteration of the particle
########
b.authorise(:star_wars, false)
b.smooth(22)
# b.smooth(3)
#
# b.authorise(:dfh, true)
# b.smooth(66)
# b.smooth(6)
# ###########

# b.password(:kgjhg)
# puts b.password
# puts b.left(555)
#
# b.authorise(:poio, false)
# b.smooth(22)


# b.authorise(:star_wars, false)
# b.smooth(22)
# b.authorise(:star_war, true)
# b.smooth(66)
# puts b.history({ operation: :write, id: :the_box, particle: :smooth })
# puts '----'
# puts "b.security : #{b.security}"
# puts '----'
# puts "user hashed pass is : #{grab(Universe.current_user).password}"
# b.authorise(:star_wars, false)
# puts "b.smooth is : #{b.smooth}"
