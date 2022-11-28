# frozen_string_literal: true

# # # frozen_string_literal: true

# # # Done : when sanitizing property must respect the order else no browser
# object will be created, try to make it more flexible allowing any order
# # # TODO int8! : language
# # # TODO : add a global sanitizer
# # # TODO : look why get_particle(:children) return an atome not the value
# # # Done : create color JS for Opal?
# # # TODO : box callback doesnt work
# # # TODO : Application is minimized all the time, we must try to condition it
# # # TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# # # TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # # DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
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
# #   @html_object.on :drag do |e|
# #     instance_exec(&proc) if proc.is_a?(Proc)
# #   end
# # end
# #
# box({width: 333, height: 333, id: :the_constraint_box, color: :orange})

# # b = box do
# #   alert  "hello"
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
# # # #TODO: when we add a color we must change the code : do we create a new color
# # # #with it's id or do we replace the old one?
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

# TODO : Check server mode there's a problem with color
# TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode

# frozen_string_literal: true

my_video2 = Atome.new(
  video: { renderers: [:browser], id: :video9, type: :video, parents: [:view], path: './medias/videos/madmax.mp4',
           left: 666, top: 333, width: 199, height: 99,
  }) do |params|
  puts "2- video callback time is  #{params}, id is : #{id}"
end
my_video2.top(33)
my_video2.left(333)

my_video2.touch(true) do
  my_video2.play(true) do |currentTime|
    puts "2 - play callback time is : #{currentTime}, id is : #{id}"
  end
  wait 2 do
    my_video2.mute(true)
    wait 3 do
      my_video2.mute
    end
  end
end



