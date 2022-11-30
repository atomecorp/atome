# frozen_string_literal: true

# # # frozen_string_literal: true

# # # Done : when sanitizing property must respect the order else no browser
# object will be created, try to make it more flexible allowing any order
# TODO int8! : language
# TODO : add a global sanitizer
# TODO : look why get_particle(:children) return an atome not the value
# Done : create color JS for Opal?
# TODO : box callback doesnt work
# TODO : Application is minimized all the time, we must try to condition it
# TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# DONE : server crash, it try to use opal_browser_method
# TODO : Check server mode there's a problem with color
# TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
# TODO : add edit method
# TODO : add add method to add children /parents/colors
# TODO : when drag update the atome's position of all children
# TODO : analysis on Bidirectional code and drag callback
# TODO : create shadow presets
# TODO : analysis on presets santitizer confusion
# TODO : optimize the use of 'generator = Genesis.generator'

##### animation #####

generator = Genesis.generator

generator.build_atome(:animation)

generator.build_render_method(:browser_animation) do |_value, _user_proc|
  @browser_type = :web
end

generator.build_particle(:targets)
generator.build_particle(:start)
generator.build_particle(:end)
generator.build_particle(:duration)

class Atome

  def animation(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :animation
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || []
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    Atome.new({ atome_type => params }, &bloc)
  end

end

generator.build_option(:pre_render_children) do |children_pass|
  children_pass.each do |child_found|
    atome_found = grab(child_found)
    atome_found.parents([])
    atome_found.parents([@atome[:id]])
  end
end

module BrowserHelper

  def self.browser_play_animation(options, browser_object_found, atome_hash, atome_object, proc)
    atome_hash[:targets].each do |target|
      atome_targeted=grab(target)
      atome_targeted_id=atome_targeted.atome[:id]
      AtomeJS.JS.animate(options,atome_targeted_id, atome_targeted)
    end
  end

end

def animation(params = {}, &proc)
  grab(:view).animation(params, &proc)
end

b = box({ id: :my_box, drag: true })
c=circle({ id: :the_circle, drag: {move: true, inertia: true, lock: :start } })

Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
aa = animation({
                 targets: [:my_box, :the_circle],
                 start: {
                   left: 33,
                   smooth: 0

                 },
                 end: {
                   left: 66,
                   smooth: 100

                 },
                 duration: 2000
               })
# alert aa.targets
aa.play(true)




s = c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow, parents: [:the_circle], children: [],
               left: 3, top: 9, blur: 19,
               red: 0, green: 0, blue: 0, alpha: 1
             })



