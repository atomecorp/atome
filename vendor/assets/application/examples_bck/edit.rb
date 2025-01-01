#  frozen_string_literal: true

new({particle: :select})
t = text :hello
t.left(99)

t.edit(true)

b=box
b.touch(true) do
  puts t.data
  t.component({ selected: true })
end

# # frozen_string_literal: true
#
# c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })
# col = c.color({ id: :col1, red: 1, blue: 1 })
# wait 2 do
#   col.red(0.6)
#   wait 2 do
#     col.red(0) # Appel en écriture
#   end
# end