# # frozen_string_literal: true
#
# # document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor = 'red'
# # alert(document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor)
#
# # TODO : when sanitizing property must respect the order else no browser object will be created, try to make it more flexible allowing any order
# # TODO : add a global sanitizer
# # TODO : look why get_particle(:children) return an atome not the value
# # TODO : create color JS for Opal?
# # TODO : box callback doesnt work
# # TODO : Application is minimized all the time, we must try to condition it
# # TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# # TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# generator = Genesis.generator
#
# generator.build_particle(:drag)
# generator.build_particle(:remove)
#
# generator.build_render_method(:html_drag) do |options, proc|
#   puts "options are #{options}"
#   @html_object[:draggable]=true
#   # @html_object.poil("toto")
#   @html_object.on :drag do |e|
#     instance_exec(&proc) if proc.is_a?(Proc)
#   end
# end
#
# # box({width: 333, height: 333, id: :the_constraint_box, color: :orange})
#
# b = box do
#   alert  "kito"
# end
#
# # cc=box.bloc.value
# # alert cc
# b.drag({ remove: true }) do |position|
#   # below here is the callback :
#   puts "1 - callback drag position: #{position}"
#   puts "1 - callback id is: #{id}"
# end
#
# # wait 4 do
# #   b.drag({ max: { left: 333 ,right: 90, top: 333, bottom: 30}})
# # end
# #
# # bb = box({ left: 120, color: :green })
# # bb.touch(true) do
# #   puts left
# # end
# #
# # bb.drag({ lock: :x }) do |position|
# #   # below here is the callback :
# #   puts "2 - drag position: #{position}"
# #   puts "2 - id is: #{id}"
# # end
# # #TODO: when we add a color we must change the code : do we create a new color with it's id or do we replace the old one?
# #
# # bbb = box({ left: 120, top: 120 })
# # bbb.drag({}) do |position|
# #   # below here is the callback :
# #   puts "bbb drag position: #{position}"
# #   puts "bbb id is: #{id}"
# # end
# # bbb.color(:black)
# #
# # bbb.remove(:drag)
# # wait 3 do
# #   bbb.drag({fixed: true}) do |position|
# #     puts position
# #   end
# # end
# #
# # circle({drag: {inside: :the_constraint_box}, color: :red})

b = box({ id: :the_box, left: 99, top: 99 })
c=b.color(:red)
# TODO: when applying atome.atome ( box.color), color should be aded to the list of box's children
s = b.shadow({ renderers: [:browser], id: :shadow2, type: :shadow, parents: [], children: [],
               left: 3, top: 9, blur: 9, direction: :inset,
               red: 0, green: 0, blue: 0, alpha: 1
             })

b.smooth(5)

# alert b

b.children([:shadow2])

s.parents([:the_box])
s.blur(39)
c.red(0.1)

b.blur(7)
# b.shadow({ left: 33 })
# shadow({ left: 33 })

# s=Atome.new(
#   shadow: { render: [:browser], id: :shadow2, type: :shadow, parents: [:view],children: [],
#            left: 3, top: 9, blur: 9,
#                     red: 1, green: 0.15, blue: 0.15, alpha: 0.6
#   }
# )
