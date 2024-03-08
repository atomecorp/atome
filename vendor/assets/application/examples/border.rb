# frozen_string_literal: true


new({particle: :inside}) do |params|
  # alert "insode : #{affect}"
end
new({ initialized: :inside }) do |params|
  # wait 1 do
  puts "affect ===> #{affect}"
  # end
end


new({ method: :inside, renderer: :html }) do |params|
  # alert affect

  if true
    affect.each do |at_found|
      grab(at_found).html.style("box-sizing", 'border-box')
      grab(at_found).html.style("left", '233px')
    end
    # html.style("box-sizing", 'border-box')
    # html.style("boxSizing", 'border-box')
    # html.style("left", '233px')
    # alert inspect◊
  else
    html.style("boxSizing", ' content-box')
  end
end


#
b=box({id: :yuyu})
bord= b.border({ thickness: 30, red: 1, green: 1, blue: 0, alpha: 1, pattern: :solid ,id: :jjjj, inside: true})
#
wait 3 do
 border({ thickness: 30, red: 1, green: 1, blue: 0, alpha: 1, pattern: :solid ,id: :poil, inside: true})

  # wait 3 do
  #   circle
  # end
end
#
# # alert bord.inspect
# # # col=color({red: ◊1, green: 0.2, id: :the_col})
# # c = circle({ id: :the_circle, color: :green })
# # b = box({ left: 333, id: :the_box })
# # circle({ top: 190, width: 99, height: 99, id: :dont_break_too })
# # c2 = circle({ top: 190, width: 99, height: 99, id: :dont_break, color: :orange })
# # # let's add the border
# # wait 1 do
# #   c2.shadow({
# #               # id: :s1,
# #               # affect: [:the_circle],
# #               left: 9,
# #               top: 3,
# #               blur: 9,
# #               invert: false,
# #               option: :natural,
# #               red: 0, green: 0, blue: 0, alpha: 1
# #             })
# #   c2.border({ thickness: 5, red: 1, green: 0, blue: 0, alpha: 1, pattern: :dotted, id: :borderline })
# # end
# # c.border({ thickness: 5, red: 1, green: 1, blue: 0, alpha: 1, pattern: :dotted })
# # b.border({ thickness: 5, red: 0, green: 1, blue: 0, alpha: 1, pattern: :dotted })
# #
# # wait 2 do
# #   c2.border({ thickness: 5, red: 1, green: 1, blue: 0, alpha: 1, pattern: :solid })
# #   c.border({ thickness: 5, red: 1, green: 1, blue: 0, alpha: 1, pattern: :dotted })
# #   b.border({ thickness: 3, red: 1, green: 1, blue: 0, alpha: 1, pattern: :dotted })
# #   b.text('touch me')
# # end
# # #
# # b.touch(true) do
# #
# #   b.border({ thickness: 5, red: 1, green: 1, blue: 1, alpha: 1, pattern: :dotted, id: :the_door,inside: true })
# #   puts " no new atome added!, number of atomes: #{Universe.atomes.length}"
# #   b.apply([:the_door])
# #   c.apply([:the_door])
# #   c2.apply([:the_door])
# #   wait 1 do
# #     # if the_door (border) is change all affect atomes are refreshed
# #     grab(:the_door).pattern(:solid)
# #     wait 1 do
# #       # if the_door (border) is change all affect atomes are refreshed
# #       grab(:the_door).thickness(20)
# #       wait 1 do
# #         # if the_door (border) is change all affect atomes are refreshed
# #         grab(:the_door).red(0)
# #         c2.color({alpha: 0})
# #
# #       end
# #     end
# #   end
# # end
# #
# # # wait 6 do
# # #   image(:red_planet)
# # # end
# #
# # # # frozen_string_literal: true
# # #
# # # col=color({red: 1, blue: 1, id: :the_col})
# # #
# # #
# # # c=circle
# # # b=box({left: 333})
# # # # b.attached([col.id])
# # # c.border({ thickness: 5, pattern: :dotted })
# # # b.border({ thickness: 5, attached: col.id, pattern: :dotted })
# # #
# #
# #
# # bb=box({top: 50, left: 100})
# # bb.text(:touch_me)
# # bord=bb.border({ thickness: 3,  pattern: :dotted, inside: true})
# # bb.touch(true) do
# #   col=bord.color({red: 1 })
# #
# #   wait 2 do
# #     col.green(1)
# #   end
# #   # bord.apply(:titi)
# #   # puts 'opk'
# # end
# #
# #
# # # c=color(:pink)
# # # # red: 1, green: 1, blue: 0, alpha: 1,
# # # wait 0.2 do
# # #   bord.red(1)
# # #   wait 0.2 do
# # #     bord.green(1)
# # #     wait 0.2 do
# # #       bord.blue(1)
# # #       wait 0.2 do
# # #         bord.alpha(1)
# # #         bord.apply(c.id)
# # #       end
# # #     end
# # #   end
# # #
# # # end