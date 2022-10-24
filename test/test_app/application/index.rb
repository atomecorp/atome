####################### animation tests
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

module Genesis

  def create_new_atomes(params, instance_var, _atome,&userproc)
    new_atome = Atome.new({},&userproc)
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
      # alert "#{atome}\n#{params}\n#{userproc}\n#{methodproc}"
      # params.delete(:bloc)
      # if I want to store the proc do it right now
      # the user proc is executed right now
      # instance_exec(params, &toto) if toto.is_a?(Proc)
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
  def set_new_atome(atome, params, userproc )
    # instance_exec(params, &proc) if proc.is_a?(Proc)
    # instance_exec(params, &userproc) if userproc.is_a?(Proc)
    params[:bloc]=userproc
    return false unless validation(atome)

    instance_var = "@#{atome}"
    # now we exec the first optional method
    params = Genesis.run_optional_methods_helper("#{atome}_pre_save_proc".to_sym, { value: params, proc: userproc })

    new_atome = create_new_atomes(params[:value], instance_var, atome, &userproc)

    # now we exec the second optional method
    Genesis.run_optional_methods_helper("#{atome}_post_save_proc".to_sym, { value: params, proc: userproc })
    @dna = "#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}"
    new_atome
  end
end

class Atome
  def initialize(params = {}, &bloc)

    # if  params.keys[0][:id] ==:video1
    #   alert params
    # end

    # instance_exec(&bloc) if proc.is_a?(bloc)

    # We initialize the renderer here
    @render = []
    # @parent = []
    @child = []
    # # TODO: check if we need to add properties for the root object before sending the params
    # alert "params : #{params}"
    # params[:shape] = { bloc: bloc }
    # params[:bloc] = { bloc: bloc }
    params.each do |atome, values|
      # We add the proc if it exist
      # alert atome

      new_atome= send(atome, values,&bloc)
      # new_atome= send(atome, values)


      # puts new_atome
      # Universe.atomes_add(new_atome)
      # puts "#{atome} #{new_atome}"
    end
    # puts "uncomment the line below and make it work!!"
    # Universe.atomes_add(self)
  end
end


#######################################################################################################################

Genesis.atome_creator_option(:shape_pre_save_proc) do |params|
  # alert params
  bloc_found=params[:value][:bloc]
  instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
  # puts "2- optional color_post_save_proc: #{params}\n"

  params
end

Genesis.atome_creator_option(:text_pre_save_proc) do |params|
  # alert params
  bloc_found=params[:value][:bloc]
  instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
  # puts "2- optional color_post_save_proc: #{params}\n"

  params
end

box({id: :my_box}) do |p|
  puts :ok_cest_ok_box
end

Atome.new(
  { shape: { render: [:html], id: :view_test, type: :shape, parent: [:view],
             left: 0, width: 90, top: 0, height: 90,overflow: :auto,
             color: { render: [:html], id: :view_test_color, type: :color,
                      red: 1, green: 0.15, blue: 0.15, alpha: 1 } } }
) do |p|
  puts "ok_cest_pout atomic box"
end

def text(params = {}, &bloc)
  Utilities.grab(:view).text(params,&bloc)
end
text({id: :my_text}) do |p|
  puts :ok_cest_ok_text
end

text = Atome.new(
  text: { render: [:html], id: :text1, type: :text, parent: [:view], visual: { size: 33 }, data: "My text!", left: 300, top: 33, width: 199, height: 33, }
)do |p|
  puts :ok_cest_ok_text_atomic
end

# # TODO:  create a video object for noobs
# # TODO: int8! : language
# # TODO: record user actions
# # TODO: separate the audio in the video
# # TODO: add mute to video

##################################### video tests #########################################

def video(params = {}, &bloc)
  # params[:bloc]=&bloc
  Utilities.grab(:view).video(params,&bloc)
end
Genesis.particle_creator(:play)


Genesis.atome_creator(:video) do |params, &proc|
  # new try here
  # instance_exec(&proc) if proc.is_a?(Proc)
  # todo:  factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "video_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id
    default_params = { render: [generated_render],id: generated_id, type: :video, parent: [generated_parent],
                       path: './medias/videos/video_missing.mp4', left: 139, top: 333, width: 199, height: 199}
    params = default_params.merge(params)
  end
  params
end



Genesis.generate_html_renderer(:video) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    video({ id: id_found, autoplay: false }).atome
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_type = :video
end



def play_video(params, &proc)
  # puts "I play the video : #{params[:atome].html_object}"
  # params[:atome].html_object.style[:left] = '33px'
  # alert params

  params[:atome].html_object.play
  # TODO : change timeupdate for when possible requestVideoFrameCallback (opal-browser/opal/browser/event.rb line 36)
  video_callback = params[:atome].bloc # this is the video callback not the play callback
  play_callback = params[:proc] # this is the video callback not the play callback
  params[:atome].html_object.on(:timeupdate) do |e|
    # video_callback = params[:atome].bloc[:bloc]
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
  exec_found= params[:proc]

  # instance_exec('::callback from video player', &exec_found) if exec_found.is_a?(Proc)
  # exec_found = params[:atome].bloc[:bloc] # this is the video callback not the play callback
  # instance_exec('::callback from video player', &exec_found) if exec_found.is_a?(Proc)
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
my_video = Atome.new(
  video: { render: [:html], id: :video1, type: :video,left: 66, top: 66, parent: [:view], path: './medias/videos/superman.mp4', left: 333, top: 333, width: 199, height: 99,
  }
) do |params|
  puts  "video callback time is  #{params}###"
end
my_video.video.top(33)
my_video.video.left(33)

my_video.video.touch(true) do
  my_video.video.play(true) do |currentTime|
    puts "play callback time is : #{currentTime}!!!"
  end
end

my_video2 = Atome.new(
  video: { render: [:html], id: :video9, type: :video,left: 366, top: 66, parent: [:view], path: './medias/videos/madmax.mp4', left: 333, top: 333, width: 199, height: 99,
  }
#FIXME : positioning doesnt work

) do |params|
  puts  "video callback time is  #{params}###"
end
my_video2.video.top(33)
my_video2.video.left(333)

my_video2.video.touch(true) do
  my_video2.video.play(true) do |currentTime|
    puts "play callback time is : #{currentTime}!!!"
  end
end





#######################################################################################################################


my_video3=video({path: './medias/videos/avengers.mp4', id: :video16}) do |params|
  # puts "temporary test uncomment below when it'll work"
  puts  "video callback here #{params}"
end
#
#
# bbb=box

  grab(:video16).on(:pause) do |event|
    alert :supercool
    # text({ data: :stopped })
  end
my_video3.touch(true) do
  grab(:video16).time(15)
  my_video3.play(true) do |currentTime|
    puts "play callback time is : #{currentTime}!!!"
  end
  wait 3 do
    grab(:video16).pause(true) do |p|
      alert :paused
    end
  end
end



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