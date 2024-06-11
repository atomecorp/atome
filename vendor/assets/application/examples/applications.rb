# frozen_string_literal: true


a = application({
                  id: :arp,
                  margin: 3,
                  # circle: { id: :test, color: :red },
                  menu: { width: 220, height: 33, depth: 333, color: :black },
                })

page1_code = lambda do |back|
  alert :kooly
end

verif = lambda do
  b = box({ id: :ty, left: 90, top: 90 })
  b.touch(true) do
    alert grab(:mod_1).touch
  end

  # a=grab('page2').circle({id: :heu, color: :black})
  # a.color(:red)
  # alert 'ok'
end

page1 = {
  id: :page1,
  color: :cyan,
  name: :accueil,
  footer: { color: :green, height: 22 },
  header: { color: :yellow },
  left_side_bar: { color: :yellowgreen },
  right_side_bar: { color: :blue },
  # box: { id: :mod_1, touch: {tap: true, code: page1_code} }
}

color({ id: :titi, red: 1 })
page2 = { id: :page2,
          color: :white,
          # apply: :titi,
          run: verif,
          # drag: true,
          box: { id: :mod_1, left: 333, top: 123, touch: { down: true, code: page1_code } }

}

page3 = { id: :page3,
          color: :red,
          # run: verif,
          # box: { id: :mod_1,left: 333, touch: {tap: :down, code: page1_code} }
}

page0 = { id: :page0,
          color: :purple,

}
a.page(page1)
a.page(page2)
a.page(page3)
# wait 1 do
#   a.page(page2)
#   wait 1 do
#     a.page(page1)
#     puts 'second load'
#     wait 5 do
#       a.page(page3)
#       wait 5 do
#         a.page(page2)
#         puts 'third load'
#       end
#     end
#   end
# end
# c=grab(:page1).circle({left: 99})
# c.touch(true) do
#   alert grab(:mod_1).inspect
# end

# wait 1 do
#   a.page(page2)
# end
# wait 2 do
#   a.page(page1)
# end
#
# wait 3  do
#   a.page(page2)
# end
#
# # wait 5 do
# #   a.page(page0)
# # end
# #
# # wait 6 do
# #   a.page(page1)
# # end

# wait 4 do
#   cc=box
#   cc.touch(true) do
#     alert  grab(:heu).inspect
#   end
# end

# a=lambda do |_val|
#   grab(:testing).color(:red)
#   wait 1 do
#     grab(:testing).delete({recursive: true})
#   end
# end
#
# c=circle
# c.touch(true) do
#   b=box({id: :testing, left: 99})
#   b.touch({ tap: true , code: a})
# end
# wait 1 do
a.show(:page1)
#   # alert :kool
# end
