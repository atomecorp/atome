# # frozen_string_literal: true
#
# bb = text({ id: :the_ref, width: 369, data: "touch me!" })
# bb.color(:orange)
# box({ id: :my_box, drag: true })
# c = circle({ id: :the_circle, left: 222, drag: { move: true, inertia: true, lock: :start } })
# c.shadow({ renderers: [:html], id: :shadow2, type: :shadow,
#            attach: [:the_circle],
#            left: 3, top: 9, blur: 19,
#            red: 0, green: 0, blue: 0, alpha: 1
#          })
#
# Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, attach: [],attached: []})
# aa = animation({
#                  targets: %i[my_box the_circle],
#                  begin: {
#                    left_add: 0,
#                    top: :self,
#                    smooth: 0,
#                    width: 3
#                  },
#                  end: {
#                    left_add: 333,
#                    top: 299,
#                    smooth: 33,
#                    width: :the_ref
#                  },
#                  duration: 800,
#                  mass: 1,
#                  damping: 1,
#                  stiffness: 1000,
#                  velocity: 1,
#                  repeat: 1,
#                  ease: 'spring'
#                }) do |pa|
#   puts "animation say#{pa}"
# end
# aa.stop(true) do |val|
#   puts " stop : #{val}"
# end
#
# aa.start(true) do |val|
#   puts " start : #{val}"
# end
#
# bb.touch(true) do
#   aa.play(true) do |po|
#     puts "play say #{po}"
#   end
# end
#
# aaa = animation({
#                   # no target for advanced animations control on callback
#                   begin: {
#                     left_add: 0,
#                     top: :self,
#                     smooth: 0,
#                     width: 3
#                   },
#                   end: {
#                     left_add: 333,
#                     top: :self,
#                     smooth: 33,
#                     width: :the_ref
#                   },
#                   duration: 1800,
#                   mass: 1,
#                   damping: 1,
#                   stiffness: 1000,
#                   velocity: 1,
#                   repeat: 1,
#                   ease: 'spring'
#                 }) do |pa|
#   puts "get params to do anything say#{pa}"
# end
# wait 7 do
#   aaa.play(true) do |po|
#     puts "play aaa say #{po}"
#   end
# end

#TODO : make the code above works
# create a animation object
# create callback methode when playing


# here is how to animate shape :
new({particle: :animate}) do |params|
  html.play_animation({ from: 0, to: 300, duration: 1000 })
end


b=box({id: :the_box})

b.animate(true)

