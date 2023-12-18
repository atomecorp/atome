#  frozen_string_literal: true


c=circle({left: 220})
t=text({left: 550,data: :hello,password: { read: { atome: :my_secret} }})
b = box({ id: :the_box, left: 66,smooth: 1.789,
          password: {
            read: {
              atome: :the_pass,
              smooth: :read_pass
            },
            write: {
              atome: :the_write_pass,
              smooth: :write_pass
            }
          }
        })



b.authorise({ read: { atome: :the_pass, smooth: :read_pass }, write: { smooth: :write_pass}, destroy: true}  )
puts b.smooth
# next will be rejected because destroy: true
puts b.smooth
#
b.authorise({ read: { atome: :wrong_pass, smooth: :no_read_pass }, write: { smooth: :wrong_write_pass}, destroy: false}  )
puts 'will send the wrong password'
puts b.smooth

b.authorise({ read: { atome: :wrong_pass, smooth: :read_pass }, write: { smooth: :wrong_write_pass}, destroy: false}  )
puts "'with send the right password it'll works"
puts b.smooth
# authorise has two params the first is the password to authorise the second is used to destroy the password or keep for
# further alteration of the particle
wait 1 do
  b.authorise({write: {smooth: :write_pass}, destroy: true} )
  b.smooth(22)
  wait 1 do
    b.smooth(12)
    wait 1 do
      b.authorise({write: {smooth: :write_pass}, destroy: false} )
      b.smooth(66)
      wait 1 do
        b.authorise({write: { smooth: :false_pass, atome: :no_apss, destroy: true}} )
        b.smooth(6)
      end
    end
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
