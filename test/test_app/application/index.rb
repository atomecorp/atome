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
#     "I play the animation : #{params}"
#     exec_found = params[:atome].bloc
#     instance_exec('::callback from anim player', &exec_found) if exec_found.is_a?(Proc)
#   end
# end
#

module Genesis

  def new_atome(atome, params, userproc, &methodproc)
    if params
      # the line below execute the proc associated to the method, ex Genesis.atome_creator(:color) do ...(proc)
      params = instance_exec(params, &methodproc) if methodproc.is_a?(Proc)
      params = add_essential_properties(atome, params)
      params = sanitizer(params)
      set_new_atome(atome, params, userproc)
    else
      get_new_atome(atome)
    end
  end

  def set_new_atome(atome, params, userproc)
    params[:bloc] = userproc
    return false unless validation(atome)

    instance_var = "@#{atome}"
    new_atome = Atome.new({}, &userproc)
    # now we exec the first optional method
    params = Genesis.run_optional_methods_helper("#{atome}_pre_save_proc".to_sym, { value: params, atome: new_atome, proc: userproc })
    new_atome = create_new_atomes(params[:value], instance_var, new_atome, &userproc)
    # now we exec the second optional method
    Genesis.run_optional_methods_helper("#{atome}_post_save_proc".to_sym, { value: params, atome: new_atome, proc: userproc })
    @dna = "#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}"
    new_atome
  end

  def create_new_atomes(params, instance_var, new_atome, &userproc)
    # new_atome = Atome.new({}, &userproc)
    Universe.atomes_add(new_atome)
    instance_variable_set(instance_var, new_atome)
    # FIXME : move this to sanitizer and ensure that no reorder happen for "id" and "render" when
    params.each do |param, value|
      new_atome.send(param, value)
    end
    new_atome
  end
end

class Atome
  def initialize(params = {}, &bloc)
    @render = []
    @child = []
    # # TODO: check if we need to add properties for the root object before sending the params
    params.each do |atome, values|
      send(atome, values, &bloc)
    end
  end
end

#######################################################################################################################

Genesis.atome_creator_option(:shape_pre_save_proc) do |params|
  current_atome = params[:atome]
  bloc_found = params[:value][:bloc]
  current_atome.instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
  params
end

Genesis.atome_creator_option(:text_pre_save_proc) do |params|
  current_atome = params[:atome]
  bloc_found = params[:value][:bloc]
  current_atome.instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
  params
end
box({ id: :my_box, left: 333 }) do |p|
  # callback is in the Genesis.atome_creator_option(:text_pre_save_proc)
  # puts "ok_cest_ok_box"
  # puts "ok_cest_ok_box, id is : #{id}"
  wait 2 do
    self.left(0)
  end
end

Atome.new(
  { shape: { render: [:html], id: :view_test, type: :shape, parent: [:view],
             left: 0, width: 90, top: 0, height: 90, overflow: :auto,
             color: { render: [:html], id: :view_test_color, type: :color,
                      red: 1, green: 0.15, blue: 0.15, alpha: 1 } } }
) do |p|
  # puts "ok_cest_pout atomic box"
  puts "ok_cest_pout atomic box, id is : #{id}"
end

def text(params = {}, &bloc)
  Utilities.grab(:view).text(params, &bloc)
end

text({ id: :my_text }) do |p|
  # puts "ok_cest_ok_text"
  puts "ok_cest_ok_text, id is : #{id}"
end

text = Atome.new(
  text: { render: [:html], id: :text1, type: :text, parent: [:view], visual: { size: 33 }, data: "My text!", left: 300, top: 33, width: 199, height: 33, }
) do |p|
  # puts "ok_cest_ok_text_atomic"
  puts "ok_cest_ok_text_atomic id is : #{id}"
end

# # TODO:  create a video object for noobs
# # TODO: int8! : language
# # TODO: record user actions
# # TODO: separate the audio in the video
# # TODO: add mute to video

##################################### video tests #########################################

def video(params = {}, &bloc)
  Utilities.grab(:view).video(params, &bloc)
end

Genesis.particle_creator(:play)

Genesis.atome_creator(:video) do |params, &proc|
  # todo:  factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "video_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id
    default_params = { render: [generated_render], id: generated_id, type: :video, parent: [generated_parent],
                       path: './medias/videos/video_missing.mp4', left: 139, top: 333, width: 199, height: 199 }
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
  params[:atome].html_object.play
  # TODO : change timeupdate for when possible requestVideoFrameCallback (opal-browser/opal/browser/event.rb line 36)
  video_callback = params[:atome].bloc # this is the video callback not the play callback
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
end

Genesis.atome_creator_option(:pause_pre_render_proc) do |params|
  params[:atome].send("pause_#{params[:atome].type}", params)
  proc_found = params[:proc]
  params[:atome].instance_exec('::call back from pause render', &proc_found) if proc_found.is_a?(Proc)
end

Genesis.particle_creator(:time)
Genesis.generate_html_renderer(:time) do |value, atome, proc|
  # params[:atome].html_object.currentTime= 33
  @html_object.currentTime = value
end

############### verif using atome.new
my_video = Atome.new(
  video: { render: [:html], id: :video1, type: :video,  parent: [:view], path: './medias/videos/superman.mp4', left: 333, top: 333, width: 199, height: 99,
  }
) do |params|
  # puts "video callback time is  #{params}"
  puts "video callback time is  #{params}, id is : #{id}"
end
my_video.video.top(33)
my_video.video.left(33)

my_video.video.touch(true) do
  my_video.video.play(true) do |currentTime|
    puts "play callback time is : #{currentTime}"
    # puts "play callback time is : #{currentTime}, id is : #{id}"
  end
end

my_video2 = Atome.new(
  video: { render: [:html], id: :video9, type: :video,  parent: [:view], path: './medias/videos/madmax.mp4', left: 666, top: 333, width: 199, height: 99,
  }
#FIXME : positioning doesnt work

) do |params|
  # puts "2- video callback time is  #{params}"
  puts "2- video callback time is  #{params}, id is : #{id}"
end
my_video2.video.top(33)
my_video2.video.left(333)

my_video2.video.touch(true) do
  my_video2.video.play(true) do |currentTime|
    # puts "2 - play callback time is : #{currentTime}"
    puts "2 - play callback time is : #{currentTime}, id is : #{id}"
  end
end

#######################################################################################################################

my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
  # puts "3 - video callback here #{params}, id is : #{id}"
  puts "3 - video callback here #{params}, id is : #{id}"
end

grab(:video16).on(:pause) do |event|
  alert ":supercool, id is : #{id}"
end
my_video3.touch(true) do
  grab(:video16).time(15)
  my_video3.play(true) do |currentTime|
    # puts "3- play callback time is : #{currentTime}"
    puts "3- play callback time is : #{currentTime}, id is : #{id}"
  end
  wait 3 do

    grab(:video16).pause(true) do |p|
      alert "paused, id is : #{id}"
    end
    # alert grab(:video16).pause
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