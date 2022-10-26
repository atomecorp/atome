# TODO: when using Rake the atomejs and others are rebuild iun test application

# ###################### animation tests
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
# ######################################
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
# my_anim.play(true)
# alert my_anim
#
# my_animation = Atome.new(
#   animator: { render: [:html], id: :anim12, type: :animator, parent: [:view], target: :image1, data: anim1, left: 333, top: 333, width: 199, height: 99,
#   }
# # animator: { render: [:html], id: :anim1, type: :animator, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
# # }
# ) do
#   puts "non proc exec added at atome creation level : #{self.class}"
# end

# ############# texts ###########



