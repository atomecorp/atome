# # frozen_string_literal: true


#
# # # # Done : when sanitizing property must respect the order else no browser
# # object will be created, try to make it more flexible allowing any order
# # TODO int8! : language
# # TODO : add a global sanitizer
# # TODO : look why get_particle(:children) return an atome not the value
# # Done : create color JS for Opal?
# # TODO : box callback doesnt work
# # TODO : Application is minimized all the time, we must try to condition it
# # TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# # TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# # DONE : server crash, it try to use opal_browser_method
# # TODO : Check server mode there's a problem with color
# # TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
# # TODO : add edit method
# # TODO : add add method to add children /parents/colors
# # TODO : when drag update the atome's position of all children
# # TODO : analysis on Bidirectional code and drag callback
# # TODO : create shadow presets
# # TODO : analysis on presets sanitizer confusion
# # TODO : optimize the use of 'generator = Genesis.generator'
# # TODO : Create a demo test of all apis
# # TODO : animate from actual position to another given position
# # TODO : keep complex property when animating (cf shadows)
# # TODO : at method is bugged : my_video.at accumulate at each video play
# # TODO : at method only accept one instance
# # Done : check the possibility of creation an instance variable for any particle proc eg : a.left do ... => @left_code
# # TODO : color, shadow, ... must be add as components not children
# # TODO :  box().left(33).color(:red).smooth(8) doesn't work as atome try to smooth the color instead of the box
# # TODO :  box().left(33).color(:red).smooth(8) doesn't work as atome try to smooth the color instead of the box

# require 'build/medias/rubies/examples/matrix'
# require 'build/medias/rubies/examples/touch'

# require 'build/medias/rubies/examples/atome_new'

a=box

alert a.instance_variables
