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
#
# require 'build/medias/rubies/examples/color'
# require 'build/medias/rubies/examples/animation'



require 'build/medias/rubies/examples/_dataset'
# require 'build/medias /rubies/examples/attach'
# require 'build/medias/rubies/examples/parents'
# require 'build/medias/rubies/examples/markers'
# require 'build/medias/rubies/examples/add'
# require 'build/medias/rubies/examples/matrix'
# require 'build/medias/rubies/examples/color'
# require 'build/medias/rubies/examples/read'
# require 'build/medias/rubies/examples/drag'
# require 'build/medias/rubies/examples/clone'
# require 'build/medias/rubies/examples/monitoring'
# require 'build/medias/rubies/examples/delete'
# a={"monitor0"=>{"left"=>{"blocs"=>[:pro_1]}}, "monitor1"=>{"width"=>{"blocs"=>[:pro_2]}}, "my_monitorer"=>{"left"=>{"blocs"=>[:pro_2]}}}

# require 'build/medias/rubies/examples/_test'



