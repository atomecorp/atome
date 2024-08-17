# #  frozen_string_literal: true
#
# b=box({id: :toto, left: 333})
#
# c=circle({id: :the_c, top: 99})
# c.over(true) do
#   alert :pouet
# end
#
#
# class Atome
#
#   def inspection(active)
#     if active
#       alert :here
#        fasten.each do |child_found|
#          current_obj= grab(child_found)
#          current_obj.over({ remove: :all })
#          puts "must get and store all over instance_method"
#          current_obj.over(true) do
#            alert current_obj.infos
#          end
#        end
#     else
#       fasten.each do |child_found|
#         current_obj= grab(child_found)
#         current_obj.over({ remove: :all })
#       end
#       puts "must restore all over instance_method"
#     end
#
#   end
# end
# b.touch(true) do
#   grab(:view).inspection(true)
# end
# c.touch(true) do
#   grab(:view).inspection(false)
# end

bb = box
cc=circle({left: 99})

cc.touch(:down) do
  puts (:first)
end
# touch test
bb.touch(:up) do
  if bb.tick(:my_counter) % 2 == 1
    cc.color(:red)
    cc.touch(:down) do
      puts(:hello)
    end
  else
    cc.color(:blue)
    cc.touch({ remove: :down })
  end
end

cc.touch(:long) do
  alert(:long)
end

# bbd=box({top: 90})
#
# bbd.touch(:long) do
#   bbd.color(:black)
# end
#
# bbd.touch(:double) do
#   bbd.color(:red)
# end

# puts Universe.particle_list
# alert Universe.atome_list
