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
# Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, attach: [],fasten: []})
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

# # here is how to animate shape :
wait 0.2 do
  puts " we wait 0.2 sec  else there's a  of a problem if we use  server wasm "

b=box({id: :the_box})

  b.animate({ to: 333, particle: :width, duration: 3000}) do |val|
    puts "width +#{val}"
  end

  b.animate({ to: 456, particle: :left, duration: 5000}) do |val|
    puts "left +#{val}"
  end

  b.animate({  end: :left}) do |val|
    puts "left ended"
  end

  b.animate({ to: 69, particle: :smooth, duration: 10000}) do |val|
    puts "smooth +#{val}"
  end

  b.animate({ end: :smooth}) do |val|
    puts " cool smooth end now!!!"
  end

  b.animate({ to: 90, particle: :rotate, duration: 10000}) do |val|
    puts "rotate +#{val}"
  end

  b.animate({ to: 222, particle: :top, duration: 10000}) do |val|
    puts "top +#{val}"
  end

end



