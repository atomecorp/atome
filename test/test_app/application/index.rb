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
#
#

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
#   def play_animator(params)
#     puts "I play the animation : #{params}"
#     exec_found = params[:atome].bloc
#     instance_exec('::callback from anim player', &exec_found) if exec_found.is_a?(Proc)
#   end
# end
#

Genesis.particle_creator(:play)


def play_video(params, &proc)
  # puts "I play the video : #{params[:atome].html_object}"
  # params[:atome].html_object.style[:left] = '33px'
  # alert proc
  params[:atome].html_object.play
  # TODO : change timeupdate for when possible requestVideoFrameCallback (opal-browser/opal/browser/event.rb line 36)
  video_callback = params[:atome].bloc[:bloc] # this is the video callback not the play callback
  play_callback = params[:proc] # this is the video callback not the play callback
  params[:atome].html_object.on(:timeupdate) do |e|
    # e.prevent # Prevent the default action (eg. form submission)
    # You can also use `e.stop` to stop propagating the event to other handlers.
    instance_exec(params[:atome].html_object.currentTime, &video_callback) if video_callback.is_a?(Proc)
    instance_exec(params[:atome].html_object.currentTime, &play_callback) if play_callback.is_a?(Proc)
  end
end

Genesis.atome_creator_option(:play_pre_render_proc) do |params|
  params[:atome].send("play_#{params[:atome].type}", params)
end

Genesis.particle_creator(:pause)

def pause_video(params, &proc)
  params[:atome].html_object.pause
  exec_found = params[:atome].bloc[:bloc] # this is the video callback not the play callback
  instance_exec('::callback from video player', &exec_found) if exec_found.is_a?(Proc)
end

Genesis.atome_creator_option(:pause_pre_render_proc) do |params|
  params[:atome].send("pause_#{params[:atome].type}", params)
  proc_found = params[:proc]
  instance_exec('::call back from pause render', &proc_found) if proc_found.is_a?(Proc)
end

Genesis.particle_creator(:time)
Genesis.generate_html_renderer(:time) do |value, atome, proc|
  # params[:atome].html_object.currentTime= 33
  @html_object.currentTime = value
end


############### verif using atome.new
# my_video = Atome.new(
#   video: { render: [:html], id: :video1, type: :video, parent: [:view], path: './medias/videos/avengers.mp4', left: 333, top: 333, width: 199, height: 99,
#   }
# ) do |params|
#   puts "video callback time is  #{params}###"
# end
#
# my_video.video.play(true) do |currentTime|
#   puts "play callback time is : #{currentTime}!!!"
# end


module Genesis

  def create_new_atomes(params, instance_var, _atome,&proc)
    new_atome = Atome.new({},&proc)
    Universe.atomes_add(new_atome)
    instance_variable_set(instance_var, new_atome)
    # FIXME : move this to sanitizer and ensure that no reorder happen for "id" and "render" when

    params.each do |param, value|
      # puts   "ici #{new_atome.class} #{new_atome}\n#{param},#{value}"
      # puts  "###### #{param},#{value}"
      new_atome.send(param, value)
    end
    new_atome
  end
  def new_atome(atome, params, userproc, &methodproc)
    if params
      # alert "methodproc : \n#{methodproc}"
      instance_exec(params, &userproc) if userproc.is_a?(Proc)
      # params[:bloc]=methodproc
      # the line below execute the proc associated to the method, ex Genesis.atome_creator(:color) do ...(proc)
      params = instance_exec(params, &methodproc) if methodproc.is_a?(Proc)
      params = add_essential_properties(atome, params)
      params = sanitizer(params)
      set_new_atome(atome, params, userproc)
    else
      get_new_atome(atome)
    end
  end
  def set_new_atome(atome, params, proc )
    # instance_exec(params, &proc) if proc.is_a?(Proc)
    # instance_exec(params, &userproc) if userproc.is_a?(Proc)

    return false unless validation(atome)

    instance_var = "@#{atome}"
    # now we exec the first optional method
    params = Genesis.run_optional_methods_helper("#{atome}_pre_save_proc".to_sym, { value: params, proc: proc })

    new_atome = create_new_atomes(params[:value], instance_var, atome,&proc)

    # now we exec the second optional method
    Genesis.run_optional_methods_helper("#{atome}_post_save_proc".to_sym, { value: params, proc: proc })
    @dna = "#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}"
    new_atome
  end
end


class Atome
  def initialize(params = {}, &proc)
    # alert "params is #{params}"
    # We initialize the renderer here
    @render = []
    # @parent = []
    @child = []
    # # TODO: check if we need to add properties for the root object before sending the params
    # alert "params : #{params}"
    params.each do |atome, values|
      # We add the proc if it exist
      values[:bloc] = { bloc: proc }
      new_atome= send(atome, values,&proc)
      # puts new_atome
      # Universe.atomes_add(new_atome)
      # puts "#{atome} #{new_atome}"
    end
    # puts "uncomment the line below and make it work!!"
    # Universe.atomes_add(self)
  end
end

Genesis.atome_creator_option(:shape_pre_save_proc) do |params|
  play_callback = params[:bloc] # this is the video callback not the play callback
  # alert "shape: \n#{params}"
  alert params
  instance_exec("kool : params", &play_callback) if play_callback.is_a?(Proc)
  # params[:atome].send("play_#{params[:atome].type}", params)
  params
end

Genesis.atome_creator_option(:text_pre_save_proc) do |params|
  play_callback = params[:proc] # this is the video callback not the play callback
  # alert "text: \n#{params}"
  # instance_exec("kool : params", &play_callback) if play_callback.is_a?(Proc)
  # params[:atome].send("play_#{params[:atome].type}", params)
  params
end

b=box({id: :my_box}) do |p|
  alert :ok_cest_ok_box
end

text=text({id: :my_text}) do |p|
  alert :ok_cest_ok_text
end
Atome.new(
  { shape: { render: [:html], id: :the_new, type: :shape, parent: [:view],
             left: 0, right: 0, top: 0, bottom: 0,overflow: :auto,
             color: { render: [:html], id: :the_new_color, type: :color,
                      red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } }
) do |p|
  alert :koolybooly
end

b.left(99) do |pa|
  alert "ok #{pa}"
end
############### verif using  video method

# module Genesis
#   def new_atome(atome, params, userproc, &methodproc)
#     if params
#       instance_exec(params, &userproc) if userproc.is_a?(Proc)
#       params = instance_exec(params, &methodproc) if methodproc.is_a?(Proc)
#       params = add_essential_properties(atome, params)
#       params = sanitizer(params)
#       set_new_atome(atome, params, userproc)
#     else
#       get_new_atome(atome)
#     end
#   end
# end
#
# my_video=video({path: './medias/videos/avengers.mp4', id: :video1}) do |params|
#   alert "temporary test uncomment below when it'll work"
#   # alert  "video callback here #{params}"
# end
#
#
# bbb=box
#
# bbb.color({ render: [:html], id: :view_color, type: :color,
#                 red: 0.15, green: 0.15, blue: 0.15, alpha: 1 }) do |params|
#   alert :tutu
# end
#
# bbb.set_color({ render: [:html], id: :view_color, type: :color,
#                 red: 0.15, green: 0.15, blue: 0.15, alpha: 1 }) do |params|
#   alert :titi
# end
#
# #
# # my_video.play(true) do |currentTime|
# #   puts "play callback time is : #{currentTime}!!!"
# # end
#
# # grab(:video1).play(true) do |currentTime|
# #     puts "play callback time is : #{currentTime}!!!"
# #   end
#
# # alert my_video
#
# ######
#
# # alert(grab(:video1))
#
#
# # wait 6 do
# #   params[:atome].html_object.pause
# # end
#
# # verif video
# # grab(:video1).time(15)
# # Universe.atomes.each do |atome_found|
# #   alert "atome found: #{atome_found.id} "
# # end
# # alert grab(:video1)
#
# b = box
# b.touch(true) do
#   alert grab(:video1)
#   grab(:video1).on(:pause) do |event|
#     alert :supercool
#     # text({ data: :stopped })
#   end
#   my_video.play(true) do |currentTime|
#     puts "play callback time is : #{currentTime}!!!"
#   end
#   wait 2 do
#     grab(:video1).time(37)
#     # alert :kool
#   end
#   wait 6 do
#     grab(:video1).pause(true) do |p|
#       alert :paused
#     end
#   end
# end
#
# ######################################
# # # Anim verif
# #
# # anim1 = {
# #   start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
# #   end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
# #   duration: 1000,
# #   loop: 1,
# #   curve: :easing,
# #   target: :my_shape
# # }
# # my_anim = animation({ data: anim1, id: :my_animation }) do |params|
# #   puts "animation params callback is : #{params} #{self.id}"
# # end
# # # my_anim.play(true)
# #
# # my_animation = Atome.new(
# #   animator: { render: [:html], id: :anim12, type: :animator, parent: [:view], target: :image1, data: anim1, left: 333, top: 333, width: 199, height: 99,
# #   }
# # # animator: { render: [:html], id: :anim1, type: :animator, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
# # # }
# # ) do
# #   puts "non proc exec added at atome creation level : #{self.class}"
# # end
#
#
#
#
#
# # TODO:  create a video object for noobs
# # TODO: int8! : language
# # TODO: record user actions
# # TODO: separate the audio in the video
# # TODO: add mute to video
#
#
#
# #
# #
# #
# # Genesis.particle_creator(:parent) do |parents|
# #   parents.each do |parent|
# #     # #TODO : create a root atome instead of using the condition below
# #     if parent != :user_view
# #       # alert "grab(parent): #{grab(parent)}"
# #       grab(parent).child << id
# #     end
# #   end
# #   parents
# # end
# #
# #
# # Genesis.atome_creator_option(:parent_pre_render_proc) do |params|
# #   unless params[:value].instance_of? Array
# #     params[:value] = [params[:value]]
# #   end
# #   params[:value]
# # end
# #
# # Genesis.generate_html_renderer(:parent) do |values, atome, proc|
# #   instance_exec(&proc) if proc.is_a?(Proc)
# #   values.each do |value|
# #     if @html_type == :style
# #       # we remove previous class if the are of the same type of the type
# #       # ex if there's a color already assign we remove it to allow the new one to be visible
# #       html_parent = grab(value).instance_variable_get("@html_object")
# #       # alert value
# #       html_parent.class_names.each do |class_name|
# #         if $document[class_name] && $document[class_name].attributes[:atome]
# #           class_to_remove = $document[class_name].attributes[:id]
# #           html_parent.remove_class(class_to_remove)
# #         end
# #       end
# #       $document[value].add_class(id)
# #     else
# #       @html_object.append_to($document[value])
# #     end
# #   end
# # end
# #
# #
# #
# #
# #
# # # alert Universe.atomes.length




