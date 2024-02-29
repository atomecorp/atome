# frozen_string_literal: true


col=color({red: 1, green: 0.2, id: :the_col})
c=circle
b=box({left: 333})
c2=circle({top: 190, width: 99, height: 99})
# let's add the border
c2.border({ thickness: 5, color: :blue, pattern: :dotted })
c.border({ thickness: 5, color: col, pattern: :dotted })
b.border({ thickness: 5, color: col, pattern: :dotted })

wait 1 do
  c2.border({ thickness: 5, color: :green, pattern: :dotted })
  c.border({ thickness: 5, color: :green, pattern: :dotted })
  b.border({ thickness: 5, color: :green, pattern: :dotted })
end

b.touch(true) do

 b.border({ thickness: 5, color: { red: 1, green: 0 }, pattern: :dotted })
 puts  " no new atome added!, number of atomes: #{Universe.atomes.length}"
end
# wait 6 do
#   iamge(:red_planet)
# end

# # frozen_string_literal: true
#
# col=color({red: 1, blue: 1, id: :the_col})
#
#
# c=circle
# b=box({left: 333})
# # b.attached([col.id])
# c.border({ thickness: 5, pattern: :dotted })
# b.border({ thickness: 5, attached: col.id, pattern: :dotted })
