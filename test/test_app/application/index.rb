# TODO: when using Rake the atomejs and others are rebuild iun test application
# TODO : maybe revert default renderer to headless istead of html
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
# #drag
class Atome
  def initialize(params = {}, &bloc)
    @render = []
    @child = []
    @html_type = :unset
    # # TODO: check if we need to add properties for the root object before sending the params
    params.each do |atome, values|
      send(atome, values, &bloc)
    end
  end
end


module Genesis
  def create_new_atomes(params, instance_var, new_atome, &userproc)
    Universe.atomes_add(new_atome)
    instance_variable_set(instance_var, new_atome)
    # FIXME : move this to sanitizer and ensure that no reorder happen for "id" and "render" when
    params.each do |param, value|
      new_atome.send(param, value)
    end
    new_atome
  end
end
Genesis.generate_html_renderer(:drag) do |value, atome, proc|
  instance_exec(&proc) if proc.is_a?(Proc)
  @html_type = :style
  $document.head << DOM("<style atome='#{type}' id='#{id}'></style>")
end

Genesis.generate_html_renderer(:drag) do |value, atome, proc|
  puts value
  # send("#{value}_html", value, atome, proc)
  # value
end

Genesis.particle_creator(:lock)
# Genesis.atome_creator(:drag) do |params|
#   params= params.merge({ render: [:headless] })
#   params
# end
Genesis.atome_creator(:drag) do |params|
  # TODO: factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "text_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    default_params = { render: [generated_render], id: generated_id, type: :drag, parent: [generated_parent]
    }
    params = default_params.merge(params)
    params
  end
  # params
end

Genesis.generate_html_renderer(:drag) do |value, atome, proc|
  alert :kool

#   `let atomeDrag = new AtomeDrag();
# atomeDrag.drag('atome');`
  # instance_exec(&proc) if proc.is_a?(Proc)
  # @html_type = :style
  # $document.head << DOM("<style atome='#{type}' id='#{id}'></style>")
end

# Genesis.generate_headless_renderer(:drag) do |value, atome, user_proc|
#   puts "msg from headless drag method: value is #{value} , atome class is #{atome.class}"
#   instance_exec(&user_proc) if user_proc.is_a?(Proc)
# end
#
# Genesis.generate_html_renderer(:drag) do |value, atome, user_proc|
#   # FIXME: we should find a s solution to pass the proc to the dragCallback toavoid the test below
#   @html_drag = user_proc if user_proc
#   if value == :remove
#     @html_object.remove_class(:draggable)
#   else
#     @html_object.add_class(:draggable)
#   end
# end
b=box

b.drag({ lock: :x, }) do |position|
  # below here is the callback :
  puts "drag position: #{position}"
  puts "id is: #{id}"
end






####################### js to erase  below
#
# class AtomeDrag {
#     constructor() {
#     }
#
#     drag(val) {
#         // target elements with the "draggable" class
#         interact('.'+val)
#             .draggable({
#                 // enable inertial throwing
#                 startAxis: 'x',
#                 lockAxis: 'x',
#                 inertia: true,
#                 // keep the element within the area of it's parent
#                 modifiers: [
#                     interact.modifiers.restrictRect({
#                         restriction: 'parent',
#                         endOnly: true
#                     })
#                 ],
#                 // enable autoScroll
#                 autoScroll: true,
#
#                 listeners: {
#                     // call this function on every dragmove event
#
#                     move: dragMoveListener,
#                     start(event) {
# //TODO:  optimise this passing the proc to the drag callback
#                         // lets get the current atome Object
#                         self.current_obj = Opal.Utilities.$grab(event.target.id)
#                         // now get the grab proc
#                         self.proc_meth = current_obj.$instance_variable_get("@html_drag")
#                     },
#                     // call this function on every dragend event
#                     end(event) {
#
#                     }
#                 }
#             })
#
#         function dragMoveListener(event) {
#             const target = event.target
#             // the code below can be conditioned to receive the drag event without moving the object
#             // keep the dragged position in the data-x/data-y attributes
#             const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
#             const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
#             // translate the element
#             target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'
#             // update the position attributes
#             target.setAttribute('data-x', x)
#             target.setAttribute('data-y', y)
#             // CallBack here
#             self.current_obj.$dragCallback(event.pageX, event.pageY, event.rect.left, event.rect.top, self.current_obj, self.proc_meth);
#         }
#     }
#
# }
#
# // Usage:
# let atomeDrag = new AtomeDrag();
# atomeDrag.drag('atome');
#
#
#
# class Atomeanimation {
#
#
# }
#
# // TODO: put in a class
#
# const atome = {
#     jsSchedule: function (years, months, days, hours, minutes, seconds, proc) {
#         const now = new Date();
#         const formatedDate = new Date(years, months - 1, days, hours, minutes, seconds);
#         const diffTime = Math.abs(formatedDate - now);
#         setTimeout(function () {
#             Opal.Object.$schedule_callback(proc);
#         }, diffTime);
#     }
# }
