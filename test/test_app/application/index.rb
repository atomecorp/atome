# frozen_string_literal: true

# # # frozen_string_literal: true

# # # Done : when sanitizing property must respect the order else no browser
# object will be created, try to make it more flexible allowing any order
# TODO int8! : language
# TODO : add a global sanitizer
# TODO : look why get_particle(:children) return an atome not the value
# Done : create color JS for Opal?
# TODO : box callback doesnt work
# TODO : Application is minimized all the time, we must try to condition it
# TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# DONE : server crash, it try to use opal_browser_method
# TODO : Check server mode there's a problem with color
# TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
# TODO : add edit method
# TODO : add add method to add children /parents/colors
# TODO : when drag update the atome's position of all children
# TODO : analysis on Bidirectional code and drag callback
# TODO : create shadow presets
# TODO : analysis on presets santitizer confusion
# TODO : optimize the use of 'generator = Genesis.generator'
# TODO : Create a demo test of all apis
# TODO : animate from actual position to another given position
# TODO : keep complex property when animating (cf shadows)


# generator = Genesis.generator
separator=120
b=box({ left: separator })
c=box({ left: b.left.value+separator })
d=box({ left: c.left.value+separator })
e=box({ left: d.left.value+separator })

b.touch(:down) do
  b.color(:red)
  c.color(:red)
  d.color(:red)
  e.color(:red)
end
b.text({data: :down})

c.touch(:long) do
  b.color(:blue)
  c.color(:blue)
  d.color(:blue)
  e.color(:blue)
end
c.text({data: :long})

d.touch(:up) do
  b.color(:yellow)
  c.color(:yellow)
  d.color(:yellow)
  e.color(:yellow)
end
d.text({data: :up})
e.touch(:double) do
  b.color(:black)
  c.color(:black)
  d.color(:black)
  e.color(:black)
end
e.text({data: :double})
# b.touch(:double) do
#   # alert :kool
#   #
#   `
#    let bell = new Audio('medias/audios/snare.wav');
# bell.play();
#   `
#   b.color(:red)
#
# #   `
# #   var audio = new Audio('medias/audios/snare.wav');
# # //audio.play();
# # //let bell = new Wad({sin : audio});
# # let bell = audio
# # //bell.play();
# # //bell.stop();
# #
# # //////
# #
# # var helloWorld = new Wad({
# #    // source: 'medias/audios/snare.wav',
# #  var audio = new Audio('medias/audios/snare.wav'),
# #    source: 'medias/audios/snare.wav',
# #     // add a key for each sprite
# #     sprite: {
# #         hello : [0, .4], // the start and end time, in seconds
# #         world : [.4,1]
# #     }
# # });
# #
# # // for each key on the sprite object in the constructor above, the wad that is created will have a key of the same name, with a play() method.
# # helloWorld.hello.play();
# # helloWorld.world.play();
# #
# # // you can still play the entire clip normally, if you want.
# # helloWorld.play();
# #
# # // if you hear clicks or pops from starting and stopping playback in the middle of the clip, you can try adding some attack and release to the envelope.
# # helloWorld.hello.play({env:{attack: .1, release:.02}})
# # `
# end



# `
# //let saw = new Wad({source : 'sawtooth'});
# let saw = new Wad({
#     source        : 'sawtooth',
#     panning       : [0, 1, 10],
#     panningModel  : 'HRTF',
#     rolloffFactor : 3 // other properties of the panner node can be specified in the constructor, or on play()
# })
# saw.play();
#`
module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and !OS.mac? and !OS.opal?
  end

  def OS.jruby?
    RUBY_ENGINE == 'jruby'
  end

  def OS.opal?
    RUBY_ENGINE == 'opal'
  end
end

# alert  OS.linux?
