# frozen_string_literal: true

b = box()
b.text('click me')

b.touch(true) do
  c = grab(:view).circle({id: :circling, left: 222, color: :orange, blur: 6 })
  c.box({id: :boxing,color: :orange, width: 33, height: 33, left: 123})
  c.box({id: :boxy,color: :red, width: 33, height: 33, left: 333})
  c.text('tap here')
  wait 0.5 do
    c.delete(:left)
    wait 0.5 do
      c.delete(:blur)
    end
  end

  c.touch(true) do
    c.delete({ recursive: true })
  end
end

############
# b = box({left: 333, id: :the_box_1})
# b.color({id: :the_orange_col, red: 1, blue: 0.5})
# b.circle({top: 66, id: :the_circle_1, color: :yellow})
#
# b.shape({id: :tutu})
# b.shape({id: :toto}) #######
# b.circle({id: :invisible}) ######
#
# wait 1 do
#   b.delete(:left)
# end
# #
# wait 3 do
#
#   b.shape.each do |attached_atome_id|
#     attached_atome_id.left(333)
#     wait 2 do
#       attached_atome_id.delete(true)
#     end
#   end
#
# end
# #
# #
# wait 4 do
#   b.delete(:color)
# end

# ################## end tests ##################
#
# # recursive example
# bb=box({id: :the_parent_box})
# bb.text({id: :text_0, data: 'test'})
# bb.text({id: :text_1, data: 'poil'})
# bb.color({id: :the_colo, red: 1})
# col=color({ id: :col_1, red: 1, green: 0.5 })
#
# # alert "before creation : #{bb}"
# bb.touch(true) do
#   bb.box({attached: col.id, id: :attached_box})
#   c=bb.circle(({ id: :circle_1 }))
#   c.text({id: :text_1, data: :hello})
#   bb.text(:good)
#   # alert "after creation : #{bb}"
#   wait 1 do
#   bb.physical.each do |attached_atome_id|
#         bb.delete({id: attached_atome_id, recursive: true})
#     end
#
#     # wait 1 do
#     #   alert "1 sec after deletion : #{bb}"
#     # end
#   end
# end

# ########################
# puts  Universe.atomes
# puts  Universe.user_atomes
# puts  Universe.system_atomes

# physical_found=["text_0","attached_box","circle_1","attached_box","circle_1"]
# clean_physical=physical_found.uniq
# alert clean_physical

# b=box(drag: true)
# c=circle
# # c.attach(b.id)
# b.attach(c.id)
# alert b
# alert c
