#  frozen_string_literal: true



b = box({ id: :the_box, left: 66,password: :toto,smooth: 1.789,
          security: {
            smooth: {
              write: { password: :other_pass },
              read: { password: :read_pass }
            }
          }
        })
puts '----'
# alert b.password
# alert Black_matter.password
# authorise has two params the first is the password to authorise the second is used to destroy the password or keep for
# further alteration of the particle
########
wait 1 do
  b.authorise(:star_wars, false)
  b.smooth(22)
  wait 1 do
    b.smooth(3)
    wait 1 do
      b.authorise(:star_wars, true)
      b.smooth(66)
      wait 1 do
        b.smooth(6)
      end
    end
  end
end
wait 5 do
  puts  b.smooth
  wait 0.1 do
    b.authorise(:star_wars, false)
    puts  b.smooth
  end
end






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
