#  frozen_string_literal: true

the_text = text({ data: 'hello for al the people in front of their machine jhgj  jg jgh jhg  iuuy res ', center: true, top: 120, width: 77, component: { size: 11 } })
the_box = box({ left: 12 })
the_circle = circle({ id: :cc, color: :orange })
the_circle.image('red_planet')
the_circle.color('red')
the_circle.box({ left: 333, id: :the_c })

element({ id: :the_element })
the_view = grab(:view)
puts "views_shape's shape are : #{the_view.shape}"
puts "the_circle color is : #{the_circle.color}"
puts "the_text data is : #{the_text.data}"
puts "the_box left is : #{the_box.left}"
puts "the_circle particles are : #{the_circle.particles}"
