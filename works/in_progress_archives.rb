a0a = :a0tOa

######################## Save API #####################
#connect({user: :toto, pass: "*****", machine: "00:3e:e1:be:0f:23"})
#eDen.load(user: :toto, pass: "*****")
#eDen.machine.send({type: :alert})
#s=script("b=box();b.color(:red)")
#save(b)

######################## find methods #####################

# c = circle({atome_id: :c, x: 300,y: 96, color: :cyan})
# c.selector({toto: :titi})
#
# text "selectors are : #{c.selector}"
# def find(params)
#   case params.keys[0]
#   when :selector
#      Atome.atomes.each do |atome|
#        if atome.selector.include?(params[:seletor])
#          alert atome.atome_id
#        end
#
#      end
#   else
#   end
# end

####################### change type  #####################

#moto=image({content: :moto, size: 96})
#t=text(:kool)

#img=image({content: :boat, parent: :view,render: false, color: :red, x: 300})
##a=Atome.new({type: :shape, content: :moto, width: 100, height: 100, color: :blue})
##b=Atome.new({"color"=>"red", "y"=>0, "z"=>0, "overflow"=>"visible", "parent"=>:view,
# "type"=>"shape", "width"=>70,
# "height"=>70, "content"=>{"points"=>4, "tension"=>"100%"}})
##t=Atome.new({type: :text, content: :moto, width: 100, height: 100, color: :blue}
#circular=circle(atome_id: :poil)
#tt=text(:hool)
#ATOME.wait  2 do
#  img.set(render: true)
#
#end
#b=circle({atome_id: :b, content: :boat})
#img=circle({content: {tension: "100%"}, parent: :view, color: :red, x: 300, preset: grab(:preset)
# [:circle],render: true})

# b=circle({atome_id: :bbbb, content: :boat, render: true})
# b=circle({atome_id: :bbbb, content: :boat, render: true})
# ATOME.wait 1 do
#   b.type(:image)
#   alert "crash in html/properties/media.rb"
#   # b.content(:moto)
#   #b.render(true)
#   ATOME.wait 1 do
#    b.content(:moto)
#    ATOME.wait 1 do
#      b.type(:text)
#      # b.content(:moto)
#      ATOME.wait 1 do
#        b.type(:shape)
#        # b.content(:moto)
#      end
#    end
#   end
# end
#
#b.touch do
#  alert b.content
#end

#a=Atome.new({type: :shape, content: :moto, width: 100, height: 100, color: :blue})
##circle
#
## Batch
#imag=image({content: :moto, size: 96})
#c = circle({atome_id: :c, x: 200})
#t = text({content: 'hello', atome_id: :t,x: 300, y: 96, width: 10, height: 33})
#e = box({atome_id: :e, x: 100})
#batch([c, t, e]).y(66).color(:cyan).rotate(33).blur(3)
#
#b=batch([c, t, e])
#
#alert b.y

#b=box({atome_id: :toto})
##b=Atome.new({type: :shape,atome_id: :toto, content: :moto, width: 100, height: 100,
# color: :blue, parent: :view})
#b.set({x: 69, y: 69})
#b.atome_id(:tut)

# box
# type mutation
#
#parent = circle({ overflow: :hidden, width: 300,
#                  height: 300, color: :orange, drag: true })
#b = parent.circle({ atome_id: :b, content: :boat, drag: true, x: 96, y: 96 })
#
#ATOME.wait 1 do
#  b.type(:image)
#  b.content(:boat)
#  ATOME.wait 1 do
#    b.content(:moto)
#    ATOME.wait 1 do
#      b.type(:text)
#      ATOME.wait 1 do
#        b.color(:cyan)
#        ATOME.wait 1 do
#          b.type(:shape)
#          ATOME.wait 1 do
#            b.type(:text)
#            b.color(:black)
#          end
#        end
#      end
#    end
#  end
#end
# type mutation

#parent = circle({ overflow: :hidden, width: 300,
#                  height: 300, color: :orange, drag: true })
#b = parent.circle({ atome_id: :b, content: :boat, drag: true, x: 96, y: 96 })
#b=circle({ atome_id: :b, content: :boat, drag: true, x: 96, y: 96 })
#ATOME.wait 1 do
#  b.type(:image)
#  b.content(:boat)
#  ATOME.wait 1 do
#    b.content(:moto)
#    ATOME.wait 1 do
#      b.type(:text)
#      # b.content(:boat)
#      ATOME.wait 1 do
#        #b.type(:shape)
#         b.content(:boat)
#      end
#    end
#  end
#end
######################### tests #####################
# play videos
#v=video({atome_id: :the_video, atome_id: :the_video_killer})
#v.touch do
#  v.play(true) do |event|
#    t.content(event)
#  end
#end
#

#b=box({atome_id: :titi,color: :orange, width: :auto, height: :auto,xx: 69, x: 69, yy: 69, y: 69})
#t=text({content:  "play position", color: :black })
#
## t=text(:guide)
## c=circle
## c.drag(true)
#b2 = box({atome_id: :toto, drag: true, color: :purple})
#c = circle({y: 96,x: 33,  atome_id: :the_circle, color: :magenta, drag: true})
#c.center(:y)
#b2.fixed(true)
#b2.center(:all)
#t = b2.text('O')
#t2 = c.text("i")
#t.center({reference: :parent, axis: :x})
#t2.center({reference: :the_circle, axis: :all})
#img=image({content: :boat, size: 69, x: 96, y: 33})
## offset means that the current x and y position is added to the centering
#img.center({axis: :x, offset: true})
#alert img.parent

# b2.position(:fixed)
#b2.xx(88)
#b2.y(88)
#
#b2.touch do
#  t.content("x: #{b.x}, y: #{b.y}, xx: #{b.xx}, yy: #{b.yy}")
#  b2.fixed(false)
#
#end

#b2.alignment({horizontal: :x, vertical: :yy})
# # alert b.alignment

# `
# mediaHelper = new MediaHelper(640, 480, 60, mediaEventListener);
# $("#view" ).append("<video id='preview'></video>");
# $("#view"  ).append("<video id='playback'></video>");
#
#
# const previewVideo = mediaHelper.addVideoPlayer('view', 'preview', true);
# const playbackVideo = mediaHelper.addVideoPlayer('view', 'playback', true);
# mediaHelper.connect(previewVideo, playbackVideo);
# `
################ camera works ####################
# v=video({atome_id: :video_id})
# v.touch do
#   v.play
# end
# cam = camera({atome_id: :camera_id, width: 700, height: 150})
# alert v.inspect
#
# alert cam.inspect
# `
# $("#view" ).append("<div style='width: 800px;height: 600px; background-color: red' id='my_input'>
# <video  >
# </video></div>");
#    const inputVideo = document.querySelector('#my_input > video');
# var width=parseInt($("#my_input").css('width'));
# var height=parseInt($("#my_input").css('height'));
#     mediaHelper = new MediaHelper(width, height, 60, inputVideo, mediaEventListener);
#     mediaHelper.connect();
# `
################ camera works ####################

# start = box(x: 0, color: "red")
# start.touch do
#   `mediaHelper.start()`
#   alert "good"
# end
# stop = box(x: 100, color: "blue")
# stop.touch do
#   `mediaHelper.stop()`
# end
# pause_resume = box(x: 200, color: "green")
# pause_resume.touch do
#   `mediaHelper.pauseOrResume()`
# end

# v=video({atome_id: :video_id})
# start demo below
# mic=microphone({atome_id: :microphone_id})
# m=midi({atome_id: :midi_id })
# alert "midi type is :#{m.type}, video type is :#{v.type}"

# `$("#view" ).append("<video id='preview'></video>");
# $("#view"  ).append("<video id='playback'></video>");
# //mediaHelper
# const previewElement = document.querySelector('#preview');
# //const playbackElement = document.querySelector('#playback');
#
# mediaHelper = new MediaHelper(640, 480, 60, previewElement);
# mediaHelper.connect();
#
# `

################# gradient test #####################

#c = circle({atome_id: :c, x: 300, id: :gradient_simple})
#c.color({green: 1})
#c.color ([:blue, :cyan])
#c.size = 223
#grad = text({content: :kool, atome_id: :gradient_test})
#grad.x(350)
#grad.y(350)
#grad.size = 223
#grad.color([:red, :yellow, {red: 0, green: 1, blue: 0}, {angle: 150}, {diffusion: :linear}])
#
#ATOME.wait 1 do
#  grad.color([:red, :yellow, {red: 0, green: 1, blue: 0}, {angle: 150}, {diffusion: :radial}])
#end
#ATOME.wait 3 do
#  c.color([:cyan, :green, :orange, {diffusion: :conic}])
#end
#ATOME.wait 5 do
#  grad.color([:orange, {red: 0, green: 1, blue: 0}, :blue, {angle: 150, diffusion: :linear}])
#end
#grad.touch do
#  text(grad.inspect)
#end
#

########## ide text size ########

#
#
# grab(:device).key({option: :down}) do |evt|
#   if evt.alt_key
#     evt.stop_propagation
#     evt.stop_immediate_propagation
#     evt.prevent_default
#     case evt.key_code
#     when 65
#       #key a
#       unless grab(:code_editor)
#         code({atome_id: :code_editor, content: :box})
#         evt.prevent_default
#       end
#     when 69
#       #key e
#       puts('console')
#     when 82
#       #key r
#       if grab(:code_editor)
#         evt.stop_propagation
#         evt.stop_immediate_propagation
#         evt.prevent_default
#         clear(:view)
#         compile(ATOME.get_ide_content("code_editor_code"))
#       end
#     when 84
#       #key t
#     when 89
#       #key y
#     when 90
#       #key z
#       if grab(:code_editor)
#         grab("code_editor").delete
#         evt.prevent_default
#       end
#     else
#     end
#   elsif evt.ctrl_key
#   else
#   end
# end
#
########################
#c=code({atome_id: :le_test, content: :box})
##c.text({size: 69})
#code_editor_font_size=12
#c=circle({size: 33})
#c2=circle({size: 33, x: 69})
#t=c.text({content: "-", center: true, color: :black})
#t2=c2.text({content: "+", center: true, color: :black, x: 69})
#t.center(true)
#t2.center(true)
#
#
#c.touch do
#  code_editor_font_size=code_editor_font_size-10
#  ATOME.set_codemirror_font_size("ide_atome_id", code_editor_font_size)
#
#end
#
#c2.touch do
#  code_editor_font_size=code_editor_font_size+10
#  ATOME.set_codemirror_font_size("ide_atome_id", code_editor_font_size)
#end