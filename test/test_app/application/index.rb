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
# require 'src/medias/rubies/examples/color'
# require 'src/medias/rubies/examples/animation'
# require 'src/medias/rubies/examples/drag'
#
# require 'src/medias/rubies/examples/_dataset'
require 'src/medias/rubies/examples/table'

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

