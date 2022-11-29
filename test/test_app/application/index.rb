# # frozen_string_literal: true
#
# # # # frozen_string_literal: true
#
# # # # Done : when sanitizing property must respect the order else no browser
# # object will be created, try to make it more flexible allowing any order
# # # # TODO int8! : language
# # # # TODO : add a global sanitizer
# # # # TODO : look why get_particle(:children) return an atome not the value
# # # # Done : create color JS for Opal?
# # # # TODO : box callback doesnt work
# # # # TODO : Application is minimized all the time, we must try to condition it
# # # # TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# # # # TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # # # DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# # # # DONE : server crash, it try to use opal_browser_method
# # TODO : Check server mode there's a problem with color
# # TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
#
# # ########## Drag to implement
#
# # class Atome
# #   def browser_drag_helper(options, parent = nil)
# #     drag_id =@atome[:id]
# #     atome_found=self
# #     options[:max] = options[:max].to_n
# # #     `current_obj = Opal.Utilities.$grab(#{drag_id})`
# # #
# # #     `interact('.'+#{drag_id})
# # #             .draggable({
# # #                 // enable inertial throwing
# # #                // startAxis: 'y',
# # #                // lockAxis: 'x',
# # #                lockAxis: #{options[:lock]},
# # #                 inertia: true,
# # #                 // keep the element within the area of it's parent
# # #                 modifiers: [
# # #                     interact.modifiers.restrictRect({
# # #                         //restriction: 'parent',
# # #                         //restriction: { left: 333 ,right: 90, top: 333, bottom: 30},
# # #                         restriction: #{options[:max]},
# # #
# # # //elementRect: { left: , right: 0, top: 1, bottom: 1 }
# # #                         // endOnly: true,
# # #                     }),
# # #
# # #                 ],
# # #                 // enable autoScroll
# # #                 autoScroll: true,
# # #
# # #                 listeners: {
# # #                     // call this function on every dragmove event
# # #
# # #                     // move: dragMoveListener,
# # #                     move: dragMoveListener,
# # #                     // move(event){
# # #                     //     console.log('current atome is: '+self.current_obj)
# # #                     // },
# # #                     start(event) {
# # #                     bloc=#{code}
# # # //TODO:  optimise this passing the proc to the drag callback
# # #                         // lets get the current atome Object
# # #                         // self.current_obj = Opal.Utilities.$grab(atome_drag_id)
# # #                         // now get the grab proc
# # #                         //self.proc_meth = current_obj.bloc
# # #                     },
# # #                     // call this function on every dragend event
# # #                     end(event) {
# # #
# # #                     }
# # #                 }
# # #             })
# # # `
# # #
# # #     if options[:fixed]
# # #       `
# # #  function allow_drag(target,x,y){
# # #
# # #   }
# # #   `
# # #     else
# # #       `
# # #  function allow_drag(target,x,y){
# # #        target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'
# # #     // update the position attributes
# # #     target.setAttribute('data-x', x)
# # #     target.setAttribute('data-y', y)
# # #   }
# # #   `
# # #     end
# # #
# # #     `
# # # function dragMoveListener(event) {
# # #     const target = event.target
# # #     // the code below can be conditioned to receive the drag event without moving the object
# # #     // keep the dragged position in the data-x/data-y attributes
# # #     const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
# # #     const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
# # #     // translate the element
# # #       allow_drag(target,x,y)
# # #     // CallBack here
# # #     var object_dragged_id=Opal.Utilities.$grab(target.id)
# # #     #{atome_found}.$dragCallback(event.pageX, event.pageY, event.rect.left, event.rect.top, #{atome_found},object_dragged_id, bloc);
# # # }
# # # `
# #   end
# #
# # end
#############################################################
generator = Genesis.generator

# def html_drag_helper(atome, options, parent = nil)
#   drag_id = atome.id
#   options[:max] = options[:max].to_n
#   `current_obj = Opal.Utilities.$grab(#{drag_id})`
#
#   `interact('.'+#{drag_id})
#             .draggable({
#                 // enable inertial throwing
#                // startAxis: 'y',
#                // lockAxis: 'x',
#                lockAxis: #{options[:lock]},
#                 inertia: true,
#                 // keep the element within the area of it's parent
#                 modifiers: [
#                     interact.modifiers.restrictRect({
#                         //restriction: 'parent',
#                         //restriction: { left: 333 ,right: 90, top: 333, bottom: 30},
#                         restriction: #{options[:max]},
#
# //elementRect: { left: , right: 0, top: 1, bottom: 1 }
#                         // endOnly: true,
#                     }),
#
#                 ],
#                 // enable autoScroll
#                 autoScroll: true,
#
#                 listeners: {
#                     // call this function on every dragmove event
#
#                     // move: dragMoveListener,
#                     move: dragMoveListener,
#                     // move(event){
#                     //     console.log('current atome is: '+self.current_obj)
#                     // },
#                     start(event) {
#                     bloc=#{atome.bloc}
# //TODO:  optimise this passing the proc to the drag callback
#                         // lets get the current atome Object
#                         // self.current_obj = Opal.Utilities.$grab(atome_drag_id)
#                         // now get the grab proc
#                         //self.proc_meth = current_obj.bloc
#                     },
#                     // call this function on every dragend event
#                     end(event) {
#
#                     }
#                 }
#             })
# `
#
#   if options[:fixed]
#     `
#  function allow_drag(target,x,y){
#
#   }
#   `
#   else
#     `
#  function allow_drag(target,x,y){
#        target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'
#     // update the position attributes
#     target.setAttribute('data-x', x)
#     target.setAttribute('data-y', y)
#   }
#   `
#   end
#
#   `
# function dragMoveListener(event) {
#     const target = event.target
#     // the code below can be conditioned to receive the drag event without moving the object
#     // keep the dragged position in the data-x/data-y attributes
#     const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
#     const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
#     // translate the element
#       allow_drag(target,x,y)
#     // CallBack here
#     var object_dragged_id=Opal.Utilities.$grab(target.id)
#     #{atome}.$dragCallback(event.pageX, event.pageY, event.rect.left, event.rect.top, #{atome},object_dragged_id, bloc);
# }
# `
# end
# generator.build_atome(:drag)
# class Atome
#   private
#
#   attr_accessor :drag_start_proc, :drag_move_proc, :drag_end_proc
#
#   public
#
#   def drag_start_callback(pageX, pageY, left, top)
#     proc = @drag_start_proc
#     instance_exec({ pageX: pageX, pageY: pageY, left: left, top: top }, &proc) if proc.is_a?(Proc)
#   end
#
#   def drag_move_callback(pageX, pageY, left, top)
#     proc = @drag_move_proc
#     instance_exec({ pageX: pageX, pageY: pageY, left: left, top: top }, &proc) if proc.is_a?(Proc)
#   end
#
#   def drag_end_callback(pageX, pageY, left, top)
#     proc = @drag_end_proc
#     instance_exec({ pageX: pageX, pageY: pageY, left: left, top: top }, &proc) if proc.is_a?(Proc)
#   end
# end

# module BrowserHelper
#   def self.browser_drag_move(params, atome_id, atome, proc)
#     atome.drag_move_proc = proc
#     AtomeJS.JS.drag(params, atome_id, atome)
#   end
#
#   def self.browser_drag_lock(params, atome_id, atome, _proc)
#     AtomeJS.JS.lock(params, atome_id, atome)
#   end
#
#   def self.browser_drag_remove(params, atome_id, atome, _proc)
#     if params == true
#       params = false
#     else
#       params = true
#     end
#     AtomeJS.JS.remove(params, atome_id, atome)
#   end
#
#   def self.browser_drag_snap(params, atome_id, atome, _proc)
#     AtomeJS.JS.snap(params.to_n, atome_id, atome)
#   end
#
#   def self.browser_drag_inertia(params, atome_id, atome, _proc)
#     AtomeJS.JS.inertia(params, atome_id, atome)
#   end
#
#   def self.browser_drag_constraint(params, atome_id, atome, _proc)
#     AtomeJS.JS.constraint(params.to_n, atome_id, atome)
#   end
#
#   def self.browser_drag_start(_params, _atome_id, atome, proc)
#     atome.drag_start_proc = proc
#   end
#
#   def self.browser_drag_end(_params, _atome_id, atome, proc)
#     atome.drag_end_proc = proc
#   end
#
# end

# generator.build_particle(:drag)

# generator.build_sanitizer(:drag) do |params|
#   if params == true
#     params = { move: true }
#   end
#   params
# end

# generator.build_render_method(:browser_drag) do |options, proc|
#   options.each do |method, params|
#     atome_id = @atome[:id]
#     BrowserHelper.send("browser_drag_#{method}", params, atome_id, self, proc)
#   end
# end



a = box({ width: 333, height: 333, id: :the_boxy })
a.color(:red)
b = box({ width: 33, height: 33, id: :the_box, drag: true })
b.color(:black)
# b.parents([:the_boxy ])
b.drag({ move: true }) do |e|
  puts e
end

# b.drag({ move: false}) do |e|
#   puts e
# end


b.drag({ start: true}) do |e|
  b.color(:yellow)
end

b.drag({ end: true}) do |e|
  b.color(:orange)
end

# b.drag({ inertia: true })

# b.drag({ lock: :start })

# b.drag({ lock: :x })

# b.drag({ remove: true })
# b.drag({ remove: false })

# b.drag({ snap: { x: 100, y: 190 } })

# b.drag({ constraint: { top: 330, left: 30, bottom: 30, right: 1 } })
# b.drag({ constraint: :parent })
# b.drag({ constraint: :the_boxy })


