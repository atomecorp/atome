# frozen_string_literal: true


# Here is the attached explanation and example :

# the attached method in atome is both a getter and a setter
# attach and attached particles serve the same purpose but just in the opposite direction
# please note that atome.attach([:atome_id]) means that atome will be the parent of the atome with the id :atome_id
# to sum up :  attach and attached are both setter and getter :
# attach will attach the current object to the IDs passed in the params. The current atome will be the child of the the atomes width IDS passed in the the params,
# while attached is the opposite to attached it will attach IDs passed in the params to the current atome. The current atome will be the parent of of the the atomes width IDS passed in the the params


# Here is how to use it as a setter :
grab(:black_matter).color({ red: 1, green: 0.6, blue: 0.6, id: :active_color })
grab(:black_matter).color({ red: 0.3, green: 1, blue: 0.3, id: :inactive_color })

b = box({ left: 99, drag: true, id: :the_box })
wait 1 do
  b.apply([:active_color])
end
c = circle({ left: 333, id: :the_circle })
wait 2 do
  c.apply(:inactive_color)
  b.attached([c.id])

  # Here is how to use it as a getter :
  # to retrieve witch atomes b315 is attached to  to the atome c_12 just type
  puts  "c.attach#{c.attach}" # => [:the_box]
  # to retrieve atome attached to the atome c_12 just type tha other method
  puts  "b.attached : #{b.attached}" #=> [:the_circle]
  puts "b.color : #{b.color}"
  puts "c.color : #{c.color}"
end




