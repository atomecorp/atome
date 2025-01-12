# frozen_string_literal: true




b=box({id: :my_b_box, left: 150, top: 150})
b.shadow({
           id: :s1,
           # affect: [:the_circle],
           left: 9, top: 3, blur: 9,
           invert: false,
           red: 0, green: 0, blue: 0, alpha: 1
         })
border1= b.border({ thickness: 15, red: 1, green: 1, blue: 0, alpha: 1, pattern: :solid ,id: :border_1, inside: true})
wait 2 do
  b.remove(:border_1)
end
wait 1.5 do
 border({ thickness: 30, red: 1, green: 1, blue: 0, alpha: 1, pattern: :solid ,id: :poil, inside: true})
end

c = circle({ id: :the_circle, color: :green })
b = box({ left: 333, id: :the_box })
circle({ top: 190, width: 99, height: 99, id: :dont_break_too })
c2 = circle({ top: 190, width: 99, height: 99, id: :dont_break, color: :orange })
# let's add the border
wait 1 do
  c2.shadow({
              left: 9,
              top: 3,
              blur: 9,
              invert: false,
              option: :natural,
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

  b.border({ thickness: 5, red: 1, green: 1, blue: 1, alpha: 1, pattern: :dotted, id: :the_door,inside: true })
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
        c2.color({alpha: 0})

      end
    end
  end
end


bb=box({top: 50, left: 100})
bb.text(:touch_me)
bord=bb.border({ thickness: 3,  pattern: :dotted, inside: true})
bb.touch(true) do
  col=bord.color({red: 1 })

  wait 2 do
    col.green(1)
  end
end
