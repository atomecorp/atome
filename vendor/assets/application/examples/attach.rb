# frozen_string_literal: true

# Here is the attach explanation and example
# the attach method in atome is both a getter and a setter
# attach and attached particles serve the same purpose but just in the opposite direction
# please note that atome.attach([:atome_id]) means that atome will be the parent of the atome with the id :atome_id
# to sum up :  attach and attached are both setter and getter :
# a.attach(b.ib) will attach the current object to the IDs passed in the params. The current atome will be the child of the the atomes width IDS passed in the the params,
# a.attach(b.ib) means (insert 'o' into 'b') or a is parent b is child

# while a.attached(b.id) (insert 'b' into 'a')is the opposite to attached it will attach IDs passed in the params to the current atome. The current atome will be the parent of of the the atomes width IDS passed in the the params
# a.attached(b.ib) means (insert 'b' into 'a') or a is child b is parent

# atome.attach([:atome_id]) means that atome will be the child of the atome with the id :atome_id
# Here is how to use it as a setter :
b = box({ id: :b315, color: :red })
circle({ id: :c_12, top: 0, drag: true, color: :yellow })

c=circle({ id: :c_123, color: :cyan, left: 233, drag: true })
 box({ id: :b_1, left: 333, drag: true })
grab(:b_1).attach(:c_123)

bb = box({ top: 99, drag: true })
bb.attach(:b_1)

box({ id: :my_test_box })
wait 1 do
  b.attach(:c_12)
  # Here is how to use it as a getter :
  # to retrieve witch atomes b315 is attached to  to the atome c_12 just type
  puts  b.attach # => [:c_12]
  # to retrieve atome attached to the atome c_12 just type tha other method
  puts  c.attached #=> [:b_1]
end
