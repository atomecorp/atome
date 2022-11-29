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

# ##### animation #####
#
# generator = Genesis.generator
#
# generator.build_atome(:animation)
#
# generator.build_render_method(:browser_animation) do |_value, _user_proc|
#   @browser_type = :web
# end
#
# generator.build_particle(:start)
# generator.build_particle(:end)
#
# class Atome
#
#   def animation(params = {}, &bloc)
#     default_renderer = Essentials.default_params[:render_engines]
#     atome_type = :animation
#     generated_render = params[:renderers] || default_renderer
#     generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
#     generated_parents = params[:parents] || []
#     params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
#     Atome.new({ atome_type => params }, &bloc)
#   end
#
# end
#
# def animation(params = {}, &proc)
#   grab(:view).animation(params, &proc)
# end
#
# # b = box({ id: :my_box })
# # a = Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
# a = animation({
#                 children: [:my_box],
#                 start: {
#                   left: 33,
#
#
#                 },
#                 end: {
#
#                 }
#               })


