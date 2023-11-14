# frozen_string_literal: true

#  here is how to setup a hierarchy within atome using a more simple way than attached and attach .simply adding atome inside another atome. here is a example to do to so : b = box({ id: :the_box })
b=box
# the line below will create a circle inside the box b
c = b.circle({ id: :the_circle })
# we can add any atome inside another atome, below we add a text inside de th box b
t = b.text({ data: :hello, left: 200, id: :the_cirle })
# theres no limit in the depht of atome, we can create an image inside the text, exemple:
t.image({ path: 'medias/images/logos/atome.svg', width: 33 })

# note that creating a hierarchy this way automatically

# Note that when you create a hierarchy in this way, it automatically creates a relationship by populating the 'attach' and 'attached' properties. So, if you enter:


puts "b attach : #{b.attach}" # prints [:view] in the console as it is attached to the view atom
puts "b attached :#{b.attached}" # prints [:the_circle, :the_cirle] in the console

puts "c attach: #{c.attach}" # prints [:the_box] in the console
puts "c attached: #{c.attached}" # prints [:box_14] in the console as there's no child