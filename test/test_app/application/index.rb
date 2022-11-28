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

module BrowserHelper
  def self.browser_drag(options, _browser_object, atome)
    atome_id=atome[:id]
    code=atome[:code]

    `
const position = { x: 0, y: 0 }


interact('#'+#{atome_id}).draggable({
  inertia: true,
  listeners: {
    start (event) {

    },
    move (event) {
      position.x += event.dx
      position.y += event.dy
       //console.log(event.type, event.dx,event.pageX, event.pageY)
// we log the real object position
      console.log(event.target.getBoundingClientRect().top)
      event.target.style.transform =
      event.target.style.transform = 'translate(' + position.x + 'px, ' + position.y + 'px)'
    },
  }
})
`

  end
end
generator.build_particle(:drag)
# generator.build_particle(:remove)

generator.build_render_method(:browser_drag) do |options, proc|
  BrowserHelper.browser_drag(options, browser_object, @atome)
  # puts "options are #{options}"
  # @browser_object[:draggable]=true
  # @browser_object.on :drag do |e|
  #   instance_exec(&proc) if proc.is_a?(Proc)
  # end
end
b= box({width: 333, height: 333, id: :the_box, color: :orange, drag: {}})
#
#
# # b.drag({ remove: true }) do |position|
# #   # below here is the callback :
# #   puts "1 - callback drag position: #{position}"
# #   puts "1 - callback id is: #{id}"
# # end
# #
# # # wait 4 do
# # #   b.drag({ max: { left: 333 ,right: 90, top: 333, bottom: 30}})
# # # end
# # #
# # # bb = box({ left: 120, color: :green })
# # # bb.touch(true) do
# # #   puts left
# # # end
# # #
# # # bb.drag({ lock: :x }) do |position|
# # #   # below here is the callback :
# # #   puts "2 - drag position: #{position}"
# # #   puts "2 - id is: #{id}"
# # # end
# # # #TODO: when we add a color we must change the code : do we create a new color
# # # #with it's id or do we replace the old one?
# # #
# # # bbb = box({ left: 120, top: 120 })
# # # bbb.drag({}) do |position|
# # #   # below here is the callback :
# # #   puts "bbb drag position: #{position}"
# # #   puts "bbb id is: #{id}"
# # # end
# # # bbb.color(:black)
# # #
# # # bbb.remove(:drag)
# # # wait 3 do
# # #   bbb.drag({fixed: true}) do |position|
# # #     puts position
# # #   end
# # # end
# # #
# # # circle({drag: {inside: :the_constraint_box}, color: :red})
#
# b = box({ id: :the_box, left: 99, top: 99 })
#
#
#
#
#
#


# b = box({ drag: true, left: 66, top: 66 })
# my_text = b.text({ data: 'drag the bloc behind me', width: 333 })
# wait 2 do
#   my_text.color(:red)
# end



