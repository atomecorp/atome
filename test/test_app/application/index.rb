# # animation atome
#
# Genesis.atome_creator(:animator)
# Genesis.generate_html_renderer(:animator) do |value, atome, proc|
#   id_found = id
#   instance_exec(&proc) if proc.is_a?(Proc)
#   DOM do
#     div(id: id_found)
#   end.append_to($document[:user_view])
#   @html_object = $document[id_found]
#   @html_type = :div
# end
# Genesis.particle_creator(:code)
#
# Genesis.atome_creator_option(:code_pre_render_proc) do |params|
#   def get_binding
#     binding
#   end
#
#   str = params[:value]
#   # eval "str + ' Fred'"
#   eval str, get_binding, __FILE__, __LINE__
#   params[:value]
# end
#
# Genesis.particle_creator(:target) do |params|
#   # alert params
# end
#
# Genesis.generate_html_renderer(:target) do |value, atome, proc|
#   @html_object
# end
#
#
#
# def animation(params = {}, &proc)
#   Utilities.grab(:view).animation(params, &proc)
# end
#
# Genesis.particle_creator(:play)
#
# class Atome
#
#   def animation(params = {}, &proc)
#     generated_id = params[:id] || "animation_#{Universe.atomes.length}"
#     generated_parent = params[:parent] || id
#
#     temp_default = { id: generated_id, type: :animator, parent: [generated_parent], bloc: proc }
#     params = temp_default.merge(params)
#     # alert params
#     new_atome = Atome.new({ animator: params })
#     new_atome.animator
#   end
#
#   def play_video(params, &proc)
#     # puts "I play the video : #{params[:atome].html_object}"
#     params[:atome].html_object.style[:left] = '33px'
#
#     params[:atome].html_object.play
#     puts "time is : #{params[:atome].html_object.currentTime}"
#     # TODO : change timeupdate for when possible requestVideoFrameCallback (opal-browser/opal/browser/event.rb line 36)
#     params[:atome].html_object.on(:timeupdate) do |e|
#       # e.prevent # Prevent the default action (eg. form submission)
#       # You can also use `e.stop` to stop propagating the event to other handlers.
#       puts "--- #{params[:atome].html_object.currentTime}:::#{e}"
#     end
#     wait 2 do
#       params[:atome].html_object.currentTime = 33
#     end
#     wait 6 do
#       params[:atome].html_object.pause
#     end
#     exec_found = params[:atome].bloc[:bloc] # this is the video callback not the play callback
#     instance_exec('::callback from video player', &exec_found) if exec_found.is_a?(Proc)
#   end
#
#   def play_animator(params)
#     puts "I play the animation : #{params}"
#     exec_found = params[:atome].bloc
#     instance_exec('::callback from anim player', &exec_found) if exec_found.is_a?(Proc)
#   end
# end
#
# Genesis.atome_creator_option(:play_pre_render_proc) do |params|
#   params[:atome].send("play_#{params[:atome].type}", params)
#   proc_found = params[:proc]
#
#   # bloc_found= params[:atome].bloc[:bloc]
#   # instance_exec("call back from play render", &bloc_found) if bloc_found.is_a?(Proc)
#   instance_exec('::call back from play render', &proc_found) if proc_found.is_a?(Proc)
# end
#
# Genesis.particle_creator(:time)
# Genesis.generate_html_renderer(:time) do |value, atome, proc|
#   # params[:atome].html_object.currentTime= 33
#   @html_object.currentTime = value
# end
#
# Genesis.particle_creator(:on) do |params|
#
# end
#
# # write({ string: :the_current_movie_is_stopped })
# Genesis.generate_html_renderer(:on) do |value, atome, proc|
#
#   @html_object.on(value) do |e|
#     text({ data: :the_current_movie_is_stopped })
#     alert :kool
#   end
#   # @html_object.currentTime= value
#
#   # @html_object.currentTime= value
# end
#
# # Anim verif
#
# anim1 = {
#   start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
#   end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
#   duration: 1000,
#   loop: 1,
#   curve: :easing,
#   target: :my_shape
# }
# my_anim = animation({ data: anim1, id: :my_animation }) do |params|
#   puts "animation params callback is : #{params} #{self.id}"
# end
# # my_anim.play(true)
#
# my_animation = Atome.new(
#   animator: { render: [:html], id: :anim12, type: :animator, parent: [:view], target: :image1, data: anim1, left: 333, top: 333, width: 199, height: 99,
#   }
# # animator: { render: [:html], id: :anim1, type: :animator, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
# # }
# ) do
#   puts "non proc exec added at atome creation level : #{self.class}"
# end
#
# my_video = Atome.new(
#   video: { render: [:html], data: :dummy, id: :video1, type: :video, parent: [:view], path: './medias/videos/avengers.mp4', left: 333, top: 333, width: 199, height: 99,
#   }
# ) do |params|
#   puts "video callback here #{params}"
# end
# # my_video.video.play(true)
#
# # TODO int8! : language
#
# # verif video
# grab(:video1).time(5)
#
# grab(:video1).on(:pause) do |event|
#   alert :stopped
# end
#
# b = box
# b.touch(true) do
#   grab(:video1).play(true) do |event|
#     puts "i am the play callback : #{event}"
#   end
# end
#
# #### code
# mycode = <<Struct
# circle({color: :red})
# Struct
#
# Atome.new(video: { id: :code1, code: mycode })
#
#
# ######## tests
#
# # ### tests ###
#
#
# # text = Atome.new(
# #   text: { render: [:html], id: :text1, type: :text, parent: [:view], visual: { size: 33 }, data: "hello!", left: 300, top: 33, width: 199, height: 33, }
# # )
# # # TODO inspect why the line below return nothing in the callback
# # text.text.data(:kool)
#
# b=box({drag: true})
# b.text({ data: :kooloii })
# TODO : Urgent write a grab(:view).clear method

read('examples/image.rb', :ruby)