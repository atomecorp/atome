# # TODO: when using Rake the atomejs and others are rebuild iun test application
# # TODO : maybe revert default renderer to headless istead of html
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


def html_drag_helper(atome, options,parent=nil)
  drag_id = atome.id
  `current_obj = Opal.Utilities.$grab(#{drag_id})`

`interact('.'+#{drag_id})
            .draggable({
                // enable inertial throwing
               // startAxis: 'y',
               // lockAxis: 'x',
               lockAxis: #{options[:lock]},
                inertia: true,
                // keep the element within the area of it's parent
                modifiers: [
                    interact.modifiers.restrictRect({
                        restriction: 'parent',
                        // endOnly: true,
                    }),

                ],
                // enable autoScroll
                autoScroll: true,

                listeners: {
                    // call this function on every dragmove event

                    // move: dragMoveListener,
                    move: dragMoveListener,
                    // move(event){
                    //     console.log('current atome is: '+self.current_obj)
                    // },
                    start(event) {
 bloc=#{atome.bloc}
//TODO:  optimise this passing the proc to the drag callback
                        // lets get the current atome Object
                        // self.current_obj = Opal.Utilities.$grab(atome_drag_id)
                        // now get the grab proc
                        //self.proc_meth = current_obj.bloc
                    },
                    // call this function on every dragend event
                    end(event) {

                    }
                }
            })
`


`
        function dragMoveListener(event) {
            const target = event.target
            // the code below can be conditioned to receive the drag event without moving the object
            // keep the dragged position in the data-x/data-y attributes
            const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
            const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
            // translate the element
            target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'
            // update the position attributes
            target.setAttribute('data-x', x)
            target.setAttribute('data-y', y)
            // CallBack here
             var object_dragged_id=target.id
            #{atome}.$dragCallback(event.pageX, event.pageY, event.rect.left, event.rect.top, #{atome},object_dragged_id, bloc);
        }
`

end

class Atome
  def drag_remove_remove(current_atome)
    current_atome.target.each do |value|
      atome_found = grab(value)
      # we get the id of the drag and ad add it as a html class to all children so they become draggable
      # atome_found.html_object.remove_class(id)
      atome_found.html_object.remove_class(current_atome.id)
    end
  end

  def shape_remove_drag(atome)
    class_to_remove=  atome.drag.id
     atome.html_object.remove_class(class_to_remove)
  end

  def dragCallback(page_x, page_y, x, y, current_object,object_dragged_id, proc=nil)
    dragged_atome=grab(object_dragged_id)
    dragged_atome.instance_variable_set('@left', x)
    dragged_atome.instance_variable_set('@top', y)
    current_object.instance_exec({ x: page_x, y: page_y }, &proc) if proc.is_a?(Proc)
  end
end

Genesis.particle_creator(:remove)
Genesis.atome_creator_option(:remove_pre_render_proc) do |params|
  type_found= params[:atome].type
  current_atome=params[:atome]
  particle_to_remove=params[:value]
  current_atome.send("#{type_found}_remove_#{particle_to_remove}",current_atome)
end

Genesis.atome_creator_option(:lock_pre_render_proc) do |params|
  current_atome= params[:atome]
  options={}
  current_atome.particles.each do |particle, value|
    options[particle]=value if (particle != :id && particle != :render && particle != :child && particle != :html_type && particle != :type && particle != :html_object && particle != :target)
  end
  options=options.merge({ lock: params[:value] })
  current_atome.target.each do |value|
    atome_found = grab(value)
    # we get the id of the drag and ad add it as a html class to all children so they become draggable
    atome_found.html_object.remove_class(current_atome.id)
    atome_found.html_object.add_class(current_atome.id)
    html_drag_helper(current_atome,options)
  end
end

Genesis.generate_html_renderer(:target) do |targets, atome, proc|
  targets.each do |value|
    atome_found = grab(value)
    # we get the id of the drag and ad add it as a html class to all children so they become draggable
    atome_found.html_object.add_class(id)
  end
  html_drag_helper(atome,{})

end

b = box

b.drag({ remove: :remove }) do |position|
  # below here is the callback :
  puts "1 - callback drag position: #{position}"
  puts "1 - callback id is: #{id}"

end

bb = box({left: 120, color: :green})
bb.touch(true) do
  alert left
end

bb.drag({ lock: :x }) do |position|
  # below here is the callback :
  puts "2 - drag position: #{position}"
  puts "2 - id is: #{id}"
end
#TODO: when we add a color we must change the code : do we create a new color with it's id or do we replace the old one?
#
bbb = box({left: 120, top: 120})
bbb.drag({ }) do |position|
  # below here is the callback :
  puts "bbb drag position: #{position}"
  puts "bbb id is: #{id}"
end
bbb.color(:red)

bbb.remove(:drag)
wait 3 do
  bbb.drag({})
end
