# # frozen_string_literal: true

# # # Done : when sanitizing property must respect the order else no browser
# object will be created, try to make it more flexible allowing any order
# TODO int8! : language
# TODO : add a global sanitizer
# TODO : look why get_particle(:children) return an atome not the value
# Done : create color JS for Opal?
# TODO : box callback doesnt work
# TODO : User application is minimized all the time, we must try to condition it
# TODO : A new atome is created each time Genesis.generator is call, we better always use the same atome
# Done : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# DONE : server crash, it try to use opal_browser_method
# TODO : Check server mode there's a problem with color
# TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
# Done : add edit method
# TODO : add add method to add children /parents/colors
# TODO : when drag update the atome's position of all children
# TODO : analysis on Bidirectional code and drag callback
# TODO : create shadow presets
# TODO : analysis on presets sanitizer confusion
# TODO : optimize the use of 'generator = Genesis.generator' it should be at one place only
# TODO : Create a demo test of all apis
# TODO : animate from actual position to another given position
# TODO : keep complex property when animating (cf shadows)
# TODO : 'at' method is bugged : my_video.at accumulate at each video play
# TODO : 'at' method only accept one instance
# Done : check the possibility of creation an instance variable for any particle proc eg : a.left do ... => @left_code
# Done : color, shadow, ... must be add as 'attach' not children
# TODO :  box().left(33).color(:red).smooth(8) doesn't work as atome try to smooth the color instead of the box
# TODO : atome have both 'set_particle' and 'particle' instance variable, eg 'set_color' and 'color' (make a choice)
# TODO : Markers
# TODO : matrix display mode
# TODO : make inheritance to avoid redundancy in Essentials/@default_params
# TODO : find a solution for the value unwanted complexity :  eg : for a.width = a.left.value
# FIXME : Monitor should be integrated as standard properties using 'generator' (eg : a.monitor doesn't return an atome)
# TODO : clones must update their original too when modified
# FIXME : try the add demo makers are totally fucked

require 'src/medias/rubies/examples/table'
# require 'src/medias/rubies/examples/web'
# require 'src/medias/rubies/examples/fullscreen'
# require 'src/medias/rubies/examples/video'
# require 'src/medias/rubies/examples/touch'
# require 'src/medias/rubies/examples/create_atome_in_atome'
# require 'src/medias/rubies/examples/color'
# require 'src/medias/rubies/examples/animation'
# require 'src/medias/rubies/examples/drag'
# require 'src/medias/rubies/examples/_dataset'
# require 'src/medias/rubies/examples/bottom'
# require 'src/medias/rubies/examples/attach'
# require 'src/medias/rubies/examples/parents'
# require 'src/medias/rubies/examples/markers'
# require 'src/medias/rubies/examples/add'
# require 'src/medias/rubies/examples/matrix'
# require 'src/medias/rubies/examples/color'
# require 'src/medias/rubies/examples/read'
# require 'src/medias/rubies/examples/drag'
# require 'src/medias/rubies/examples/clone'
# require 'src/medias/rubies/examples/monitoring'
# require 'src/medias/rubies/examples/delete'
# require 'src/medias/rubies/examples/_audio'
# a={"monitor0"=>{"left"=>{"blocs"=>[:pro_1]}}, "monitor1"=>{"width"=>{"blocs"=>[:pro_2]}}, "my_monitorer"=>{"left"=>{"blocs"=>[:pro_2]}}}

# require 'src/medias/rubies/examples/_test'
# image(date: :boat)

# `
# var helloWorld = new Wad({
#     source: './medias/audios/Binrpilot.mp3',
#
#     // add a key for each sprite
#     sprite: {
#         hello : [0, .4], // the start and end time, in seconds
#         world : [.4,1]
#     }
# });
#
# // for each key on the sprite object in the constructor above, the wad that is created will have a key of the same name, with a play() method.
# //helloWorld.hello.play();
# //helloWorld.world.play();
#
# // you can still play the entire clip normally, if you want.
# helloWorld.play();
#
# // if you hear clicks or pops from starting and stopping playback in the middle of the clip, you can try adding some attack and release to the envelope.
# //helloWorld.hello.play({env:{attack: .1, release:.02}})
#

# generator = Genesis.generator
#
# generator.build_particle(:red) do
#   # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
#   self
# end
#
# generator.build_render(:red) do |value|
#   red = ((@atome[:red] = value) * 255)
#   green = @atome[:green] * 255
#   blue = @atome[:blue] * 255
#   alpha = @atome[:alpha]
#   color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
#   BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
#   # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
#   self
# end

# Anime repair

#
# bb = box({ id: :the_ref, width: 369 })
# bb.color(:red)
# box({ id: :my_box, drag: true })
# c = circle({ id: :the_circle, left: 222, drag: { move: true, inertia: true, lock: :start } })
# c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow,
#            parents: [:the_circle], children: [],
#            left: 3, top: 9, blur: 19,
#            red: 0, green: 0, blue: 0, alpha: 1
#          })
#
# Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
# class Atome
#
#   def atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
#     temp_default = Essentials.default_params[atome_type] || {}
#     temp_default[:id] = generated_id
#     temp_default[:parents] = generated_parents
#     temp_default[:clones] = []
#     temp_default[:renderers] = generated_render
#     temp_default[:children] = generated_children.concat(temp_default[:children])
#     temp_default.merge(params)
#   end
#   def animation(params = {}, &bloc)
#     default_renderer = Essentials.default_params[:render_engines]
#     atome_type = :animation
#     generated_render = params[:renderers] || default_renderer
#     generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
#     generated_parents = params[:parents] || []
#     generated_children = params[:children] || []
#     params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
#     Atome.new({ atome_type => params }, &bloc)
#   end
# end
# aa = animation(
#   {
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
#                }
# ) do |pa|
#   puts "animation say#{pa}"
# end

# # video repair
#
# # frozen_string_literal: true
#
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
# # #############
# # my_video2 = Atome.new(
# #   video: { renderers: [:browser], id: :video9, type: :video, parents: [:view], path: './medias/videos/madmax.mp4',
# #            left: 666, top: 333, width: 199, height: 99,
# #   }) do |params|
# #   puts "2- video callback time is  #{params}, id is : #{id}"
# # end
# # my_video2.top(33)
# # my_video2.left(333)
# #
# # my_video2.touch(true) do
# #   my_video2.play(true) do |currentTime|
# #     puts "2 - play callback time is : #{currentTime}, id is : #{id}"
# #   end
# # end
# #
# # #############
# # my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
# #   puts "3 - video callback here #{params}, id is : #{id}"
# # end
# # my_video3.width = my_video3.height = 333
# # my_video3.left(555)
# # grab(:video16).on(:pause) do |_event|
# #   puts "id is : #{id}"
# # end
# # my_video3.touch(true) do
# #   grab(:video16).time(15)
# #   my_video3.play(true) do |currentTime|
# #     puts "3- play callback time is : #{currentTime}, id is : #{id}"
# #   end
# #   wait 3 do
# #     puts "time is :#{my_video3.time}"
# #   end
# #   wait 6 do
# #     grab(:video16).pause(true) do |time|
# #       puts "paused at #{time} id is : #{id}"
# #     end
# #   end
# # end

# generator=Genesis.generator
# generator.build_particle(:hook) do |targets|
#   targets.each do |target|
#     grab(target).attach([atome[:id]])
#   end
# end

# ###########################

