#  frozen_string_literal: true

b = box({ id: :the_box, left: 66,
          security: {
            smooth: {
              write: { password: :other_pass },
              read: { password: :read_pass }
            }
          }
        })

b.authorise(:star_wars, false)
b.smooth(22)
b.authorise(:star_war, true)
b.smooth(66)
puts b.history({ operation: :write, id: :the_box, particle: :smooth })
puts '----'
puts "b.security : #{b.security}"
puts '----'
puts "user hashed pass is : #{grab(Universe.current_user).password}"
b.authorise(:star_wars, false)
puts "b.smooth is : #{b.smooth}"