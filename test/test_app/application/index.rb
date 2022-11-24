# # # frozen_string_literal: true
# #
# # # document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor = 'red'
# # # alert(document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor)
# #
# # # Done : when sanitizing property must respect the order else no browser object will be created, try to make it more flexible allowing any order
# # # TODO : add a global sanitizer
# # # TODO : look why get_particle(:children) return an atome not the value
# # # Done : create color JS for Opal?
# # # TODO : box callback doesnt work
# # # TODO : Application is minimized all the time, we must try to condition it
# # # TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# # # TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # # Done : server crash, it try to use opal_browser_method
#
# # generator = Genesis.generator
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
# # # box({width: 333, height: 333, id: :the_constraint_box, color: :orange})
# #
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
#
# c = b.color(:red)
# wait 1 do
#   c.red(0.3)
# end
# # TODO: when applying atome.atome ( box.color), color should be aded to the list of box's children
# s = b.shadow({ renderers: [:browser], id: :shadow2, type: :shadow, parents: [], children: [],
#                left: 3, top: 9, blur: 3, direction: :inset,
#                red: 0, green: 0, blue: 0, alpha: 1
#              })
#
# b.smooth(5)
# # alert b.atome[:type]
# # alert b
#
# b.children([:shadow2])
#
# s.parents([:the_box])
# wait 1 do
#   s.blur(9)
#   wait 1 do
#     wait 2 do
#       s.green(0)
#       s.left(14)
#     end
#     s.left(44)
#     s.green(0.7)
#   end
#   # s.color(:blue)
# end
#
# # b.blur(2)
# # b.shadow({ left: 33 })
# # shadow({ left: 33 })
#
# # s=Atome.new(
# #   shadow: { render: [:browser], id: :shadow2, type: :shadow, parents: [:view],children: [],
# #            left: 3, top: 9, blur: 9,
# #                     red: 1, green: 0.15, blue: 0.15, alpha: 0.6
# #   }
# # )
#
# # Atome.new(
# #   shape: { type: :shape, renderers: [:browser], id: :the_shape, parents: [:view], children: [],
# #            left: 99, right: 99, width: 399, height: 99,
# #            color: { render: [:browser], id: :c315, type: :color, parents: [:the_shape],children: [],
# #                     red: 0.3, green: 1, blue: 0.6, alpha: 1 } }
# # )
# #
# aa = Atome.new(
#   shape: { renderers: [:browser], id: :the_shape2, type: :shape, parents: [:view], children: [],
#            left: 99, right: 99, width: 99, height: 99,
#            color: { render: [:browser], id: :c31, type: :color, parents: [:the_shape2], children: [],
#                     left: 33, top: 66, red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
# )
#
# ccc = Atome.new({ color: { renderers: [:browser], id: :c31, type: :color, parents: [:the_shape2], children: [],
#                            left: 33, top: 66, red: 0, green: 0.15, blue: 0.7, alpha: 0.6 } })
#
# cc = aa.color
#
# ccc.left(99)
#
# # alert a.document
# # class BrowserHelper
# #   def self.browser_document
# #     # Work because of the patched versio of opal-browser(0.39)
# #     Browser.window
# #   end
# #
# #   def self.get(id)
# #     @element= browser_document[id]
# #      self
# #   end
# #
# #   def append
# #     @element
# #   end
# #
# # end
# # # alert BrowserHelper.get(:user_view)
# # # BrowserHelper.get(:user_view) << "Hello world!"
# # BrowserHelper.get(:user_view).append("Hello world!iii")
#
# # alert Essentials.default_params[:render_engines]
#
# # Essentials.new_default_params({ render_engines: [:headless] })
#
# # alert Essentials.default_params
# # alert Essentials.default_params[:render_engines]
# sampler = {
#   note1: { velocity1: {
#     sample1: {
#       start: 0,
#       end: 123_765,
#       loop_start: 34,
#       loop_end: 678,
#       repeat: 3,
#       loop_fade: 34 },
#     reverse: true,
#     adsr: :adsr_id,
#     sample2: {}
#   }
#   } }
# sampler

# ########## text
# text({ id: :my_text, color: :lightgray }) do |p|
#   puts "ok text id is : #{id}"
# end
#
# text = Atome.new(
#   text: { render: [:html], id: :text1, type: :text, parents: [:view], visual: { size: 33 }, data: "My text!", left: 300, top: 33, width: 199, height: 33, }
# ) do |p|
#   puts "ok Atome.new(text) id is : #{id}"
# end
# wait 1.2 do
#   text.text.data(:kool)
# end
#
# b = box({ drag: true, left: 66, top: 66 })
# my_text = b.text({ data: 'drag the bloc behind me', width: 333 })
# wait 2 do
#   my_text.color(:red)
# end

# Atome.new(container: {id: :atome_presets, type: :element ,data: :hello, renderers: []})

element(data: :hello_world)
alert Universe.atomes.keys


box
circle

