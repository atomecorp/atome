# # # frozen_string_literal: true

# # # Done : when sanitizing property must respect the order else no browser object will be created, try to make it more flexible allowing any order
# # # TODO : add a global sanitizer
# # # TODO : look why get_particle(:children) return an atome not the value
# # # Done : create color JS for Opal?
# # # TODO : box callback doesnt work
# # # TODO : Application is minimized all the time, we must try to condition it
# # # TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# # # TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # # DOME: when applying atome.atome ( box.color), color should be aded to the list of box's children
# # # DONE : server crash, it try to use opal_browser_method

# ########## Drag to implement
# generator = Genesis.generator
# #
# # generator.build_particle(:drag)
# # generator.build_particle(:remove)
# #
# # generator.build_render_method(:html_drag) do |options, proc|
# #   puts "options are #{options}"
# #   @html_object[:draggable]=true
# #   # @html_object.poil("toto")
# #   @html_object.on :drag do |e|
# #     instance_exec(&proc) if proc.is_a?(Proc)
# #   end
# # end
# #
# box({width: 333, height: 333, id: :the_constraint_box, color: :orange})

# # b = box do
# #   alert  "kito"
# # end
# #
# # # cc=box.bloc.value
# # # alert cc
# # b.drag({ remove: true }) do |position|
# #   # below here is the callback :
# #   puts "1 - callback drag position: #{position}"
# #   puts "1 - callback id is: #{id}"
# # end
# #
# # # wait 4 do
# # #   b.drag({ max: { left: 333 ,right: 90, top: 333, bottom: 30}})
# # # end
# # #
# # # bb = box({ left: 120, color: :green })
# # # bb.touch(true) do
# # #   puts left
# # # end
# # #
# # # bb.drag({ lock: :x }) do |position|
# # #   # below here is the callback :
# # #   puts "2 - drag position: #{position}"
# # #   puts "2 - id is: #{id}"
# # # end
# # # #TODO: when we add a color we must change the code : do we create a new color with it's id or do we replace the old one?
# # #
# # # bbb = box({ left: 120, top: 120 })
# # # bbb.drag({}) do |position|
# # #   # below here is the callback :
# # #   puts "bbb drag position: #{position}"
# # #   puts "bbb id is: #{id}"
# # # end
# # # bbb.color(:black)
# # #
# # # bbb.remove(:drag)
# # # wait 3 do
# # #   bbb.drag({fixed: true}) do |position|
# # #     puts position
# # #   end
# # # end
# # #
# # # circle({drag: {inside: :the_constraint_box}, color: :red})
#
# b = box({ id: :the_box, left: 99, top: 99 })

# b = box({ drag: true, left: 66, top: 66 })
# my_text = b.text({ data: 'drag the bloc behind me', width: 333 })
# wait 2 do
#   my_text.color(:red)
# end

# frozen_string_literal: true

b = box({ width: 333, left: 333 })
b.rotate(999)