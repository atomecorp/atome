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

generator = Genesis.generator

######### Video
# generator.build_render_method(:browser_video) do |_value, _user_proc|
#   @browser_type = :div
#   id_found = @atome[:id]
#   DOM do
#     video({ id: id_found, autoplay: false, loop: false, muted: true }).atome
#   end.append_to(BrowserHelper.browser_document[:user_view])
#   @browser_object = BrowserHelper.browser_document[id_found]
# end

######### PLay
# generator.build_particle(:play)

# generator.build_render_method(:browser_play) do |value, proc|
#   BrowserHelper.send("browser_play_#{@atome[:type]}", value, @browser_object, @atome, self, proc)
# end

# def browser_play_video(value, browser_object_found, atome_found, atome_object, proc)
#   browser_object_found.play
#   # # TODO : change timeupdate for when possible requestVideoFrameCallback (opal-browser/opal/browser/event.rb line 36)
#   video_callback = atome_found[:code] # this is the video callback not the play callback
#   play_callback = proc # this is the video callback not the play callback
#   browser_object_found.on(:timeupdate) do |e|
#     e.prevent # Prevent the default action (eg. form submission)
#     # You can also use `e.stop` to stop propagating the event to other handlers.
#     current_time = browser_object_found.currentTime
#     atome_object.instance_exec(current_time, &video_callback) if video_callback.is_a?(Proc)
#     atome_object.instance_exec(current_time, &play_callback) if play_callback.is_a?(Proc)
#   end
# end

# time
# generator.build_particle(:time)

# generator.build_render_method(:browser_time) do |value=nil, proc|
#   if value
#     @browser_object.currentTime = value
#   else
#     @browser_object.currentTime
#   end
# end

# pause
# generator.build_particle(:pause)

# generator.build_render_method(:browser_pause) do |value, proc|
#   instance_exec(@browser_object.currentTime, &proc) if proc.is_a?(Proc)
#   @browser_object.pause
# end

#on 

# generator.build_particle(:on)

# generator.build_render_method(:on) do |value, proc|
#   @browser_object.on(value) do |e|
#     instance_exec(e, &proc) if proc.is_a?(Proc)
#   end
# end

# frozen_string_literal: true
###############@
# my_video = Atome.new(
#   video: { renderers: [:browser], id: :video1, type: :video, parents: [:view], path: './medias/videos/superman.mp4',
#            left: 333, top: 112, width: 199, height: 99
#   }
# ) do |params|
#   # puts "video callback time is  #{params}, id is : #{id}"
#   puts "video callback time is  #{params}, id is : #{id}"
# end
# wait 2 do
#   my_video.left(33)
#   my_video.width(444)
#   my_video.height(444)
#
# end
#
# my_video.touch(true) do
#   my_video.play(true) do |currentTime|
#     puts "play callback time is : #{currentTime}"
#   end
# end
# #############
# my_video2 = Atome.new(
#   video: { renderers: [:browser], id: :video9, type: :video,  parents: [:view], path: './medias/videos/madmax.mp4',
#            left: 666, top: 333, width: 199, height: 99,
#   }) do |params|
#   puts "2- video callback time is  #{params}, id is : #{id}"
# end
# my_video2.top(33)
# my_video2.left(333)
#
# my_video2.touch(true) do
#   my_video2.play(true) do |currentTime|
#     puts "2 - play callback time is : #{currentTime}, id is : #{id}"
#   end
# end
#
# #############
# my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
#   puts "3 - video callback here #{params}, id is : #{id}"
# end
# my_video3.width=my_video3.height=333
#   my_video3.left(555)
# grab(:video16).on(:pause) do |event|
#   puts ":supercool, id is : #{id}"
# end
# my_video3.touch(true) do
#   grab(:video16).time(15)
#   my_video3.play(true) do |currentTime|
#     puts "3- play callback time is : #{currentTime}, id is : #{id}"
#   end
#   wait 3 do
#     puts "time is :#{my_video3.time}"
#   end
#   wait 6 do
#     grab(:video16).pause(true) do |time|
#       puts "paused at #{time} id is : #{id}"
#     end
#   end
# end

##############@ on
my_video = Atome.new(
  video: { renderers: [:browser],  id: :video1, type: :video, parents: [:view],
           path: './medias/videos/avengers.mp4', left: 333, top: 33, width: 777
  }
) do |params|
  puts "video callback here #{params}"
end
my_video.play(true)


my_video.touch(true) do
  my_video.fullscreen
end



