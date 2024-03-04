# frozen_string_literal: true

# col=color({red: 1, green: 0.2, id: :the_col})
c = circle({ id: :the_circle })
b = box({ left: 333, id: :the_box })
c2 = circle({ top: 190, width: 99, height: 99, id: :dont_break })
# let's add the border
wait 1 do
  c2.shadow({
              # id: :s1,
              # affect: [:the_circle],
              left: 9,
              top: 3,
              blur: 9,
              invert: false,
              red: 0, green: 0, blue: 0, alpha: 1
            })
  c2.border({ thickness: 5, red: 1, green: 0, blue: 0, alpha: 1, pattern: :dotted, id: :borderline })
end
c.border({ thickness: 5, red: 1, green: 1, blue: 0, alpha: 1, pattern: :dotted })
b.border({ thickness: 5, red: 0, green: 1, blue: 0, alpha: 1, pattern: :dotted })

wait 2 do
  c2.border({ thickness: 5, red: 1, green: 1, blue: 0, alpha: 1, pattern: :solid })
  c.border({ thickness: 5, red: 1, green: 1, blue: 0, alpha: 1, pattern: :dotted })
  b.border({ thickness: 3, red: 1, green: 1, blue: 0, alpha: 1, pattern: :dotted })
  b.text('touch me')
end
#
b.touch(true) do

  b.border({ thickness: 5, red: 1, green: 1, blue: 1, alpha: 1, pattern: :dotted, id: :the_door })
  puts " no new atome added!, number of atomes: #{Universe.atomes.length}"
  b.apply([:the_door])
  c.apply([:the_door])
  c2.apply([:the_door])
  wait 1 do
    # if the_door (border) is change all affect atomes are refreshed
    grab(:the_door).pattern(:solid)
    wait 1 do
      # if the_door (border) is change all affect atomes are refreshed
      grab(:the_door).thickness(20)
      wait 1 do
        # if the_door (border) is change all affect atomes are refreshed
        grab(:the_door).red(0)
      end
    end
  end
end

# wait 6 do
#   image(:red_planet)
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
