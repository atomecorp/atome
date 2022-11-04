# # TODO: when using Rake the atomejs and others are rebuild iun test application
# # TODO : maybe revert default renderer to headless instead of html
# # TODO : over
# # TODO :shadow
# #TODO : text align
# #TODO : audio objct
# # ###################### animation tests
# #
# # Genesis.atome_creator(:animator)
# # Genesis.generate_html_renderer(:animator) do |value, atome, proc|
# #   id_found = id
# #   instance_exec(&proc) if proc.is_a?(Proc)
# #   DOM do
# #     div(id: id_found)
# #   end.append_to($document[:user_view])
# #   @html_object = $document[id_found]
# #   @html_type = :div
# # end
# #
# #
# #
# #
# # Genesis.particle_creator(:target) do |params|
# #   # alert params
# # end
# #
# # Genesis.generate_html_renderer(:target) do |value, atome, proc|
# #   @html_object
# # end
# #
# #
# #
# # def animation(params = {}, &proc)
# #   Utilities.grab(:view).animation(params, &proc)
# # end
# #
# #
# # class Atome
# #
# #   def animation(params = {}, &proc)
# #     generated_id = params[:id] || "animation_#{Universe.atomes.length}"
# #     generated_parent = params[:parent] || id
# #
# #     temp_default = { id: generated_id, type: :animator, parent: [generated_parent], bloc: proc }
# #     params = temp_default.merge(params)
# #     # alert params
# #     new_atome = Atome.new({ animator: params })
# #     new_atome.animator
# #   end
# #
# #   def play_animator(params)
# #     "I play the animation : #{params}"
# #     exec_found = params[:atome].bloc
# #     instance_exec('::callback from anim player', &exec_found) if exec_found.is_a?(Proc)
# #   end
# # end
# #
# # ######################################
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
# # my_anim.play(true)
# # alert my_anim
# #
# # my_animation = Atome.new(
# #   animator: { render: [:html], id: :anim12, type: :animator, parent: [:view], target: :image1, data: anim1, left: 333, top: 333, width: 199, height: 99,
# #   }
# # # animator: { render: [:html], id: :anim1, type: :animator, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
# # # }
# # ) do
# #   puts "non proc exec added at atome creation level : #{self.class}"
# # end
# ############# Drag ###########

$window.on :resize do |e|
  puts $window.view.height
end

# TODO: when we add a color we must change the code : do we create a new color with it's id or do we replace the old one?
# TODO: gem install webrick  ; ruby -run -e httpd . -p 8080
# TODO: new id Scheme base on id, with verification if already exist
# FIXME : if we change the id, changing the color crash
# TODO : maybe add Shape, text, Image, etc.. Classes to simplify type exeption methods
# TODO : maybe add Genesis as an atome module to be in the context of the atome to simplify and accelerate methods treatment
# TODO :  image.width return O instead of the real size
# TODO (DONE):   catch data for every atome type cf : (image_1.data(:kool))
# TODO: on resize
# TOD0 : \n not respected in text atome

# my_video=video({ path: "./medias/videos/madmax.mp4", left: 6, top: 120, width: 666, height: 666})
# my_video.touch(true) do
#   my_video.play(true)
# end

# Atome.new(
#   { shape: { render: [:html], id: :my_test, type: :shape, parent: [:user_view],
#              left: 0, right: 0, width: 110, height: 100,overflow: :auto,
#              color: { render: [:html], id: :my_test_color, type: :color,
#                         red: 1 } } }
# )

# b=box
# alert b
# please note that render , id and type params must place in order

# box({left: 99, top: 99, shadow:{blur: 9, left: 3, top: 3, color: :black}})

# b = circle({ id: :my_box })

Genesis.atome_creator(:shadow) do |params|
  # TODO: factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "shadow_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id
    default_params = { render: [generated_render], id: generated_id, type: :shadow, parent: [generated_parent] }
    params = default_params.merge(params)
    params
  end
end

Genesis.generate_html_renderer(:shadow) do |value, atome, proc|
  instance_exec(&proc) if proc.is_a?(Proc)
  @html_type = :shadow
  # we remove previous unused style tag
  $document[id].remove if $document[id]
  $document.head << DOM("<style atome='#{type}'  id='#{id}'></style>")
end

Genesis.atome_creator_option(:shadow_post_save_proc) do |params|
  # alert :ok
  # current_atome = params[:atome]
  # #FIXME: look why we have to look in [:value][:value] this looks suspect
  # bloc_found = params[:value][:value][:bloc]
  # current_atome.instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
  params
end

# Genesis.atome_creator_option(:left_render_proc) do |params|
#
# end

# alert shadow
# b.shadow({left: 3}) do
#   alert :jhg
# end

# # TODO : Make it work
# wait 2 do
#   grab(:view).clear
#   # FIXME :  this cause add_class for nil error
#   b.color(:red)
# end
#
# wait 3 do
#   # b.delete
#   d=  grab(:my_box )
#   # alert b
#   # FIXME :  this cause an @ is not an instance variable name error
#   d.refresh
# end

#
# # TODO : make it work too
# Genesis.particle_creator(:parent) do |parents|
#   # if parents.length==0
#     parents=[:view]
#
#   # end
#   # alert parents.length
#   parents.each do |parent|
#     #TODO : create a root atome instead of using the condition below
#     if parent != :user_view
#       grab(parent).child << id
#     end
#   end
#   parents
# end
# def color(params = {}, &bloc)
#   new_element=Atome.new({render: [:headless], parent: [:view]})
#
#   new_element.color(params, &bloc)
#     # Utilities.grab(:view).color(params, &bloc)
# end
# c=color(:orange)
def shape_left(val)

end

def shadow_left(val)

end
# Genesis.atome_creator_option(:left_pre_render_proc) do |params|
#   alert "#{params[:method]}, #{params[:atome].type}"
#   params[:atome].send("#{params[:atome].type}_#{params[:method]}")
#
# end
Genesis.atome_creator_option(:left_render_proc) do |params|
  alert params
end

b=box({left: 99})
wait 1 do
  b.shadow({left: 1})
end

# image({ path: "./medias/images/moto.png", left: 33, bottom: 33 })
#
# #methods below
# b.color(c)
# b.attach((c))

# ################ add new class for atome type
# def new_class(class_name)
#   new_class = Class.new(Atome) do
#   end
#   Object.const_set(class_name, new_class)
# end
#
# new_class('Shadow')
#
# class Shadow
#   def left val
#     alert "left val is #{val}"
#   end
# end
#
# c = Shadow.new({})
# c.left(999)
# # shadow = b.shadow({ left: 33, blur: 33 })
