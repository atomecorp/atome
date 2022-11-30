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
# TODO : Create a demo test of all apis


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
  ################### Generator atome
  def animation(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :animation
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || []
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    Atome.new({ atome_type => params }, &bloc)
  end

  ################### callbacks

  def Browser_animate_callback(particle_found, value)
    # puts particle_found,  value
    # atome_found.$play_active_callback(particle_found, v);
    @atome[particle_found]=value
     browser_object.style[particle_found] = "#{value}px"
  end

  def play_start_callback(particle_found, value)
    @atome[particle_found] = value
    play_proc = play_start_proc
    anim_proc = animation_start_proc
    instance_exec({ @atome[particle_found] => value }, &play_proc) if play_proc.is_a?(Proc)
    instance_exec({ @atome[particle_found] => value }, &anim_proc) if anim_proc.is_a?(Proc)
  end

  def play_active_callback(particle_found, value)
    @atome[particle_found] = value
    play_proc = play_active_proc
    anim_proc = animation_active_proc
    instance_exec({ @atome[particle_found] => value }, &play_proc) if play_proc.is_a?(Proc)
    instance_exec({ @atome[particle_found] => value }, &anim_proc) if anim_proc.is_a?(Proc)
  end

  def play_stop_callback(particle_found, value)
    @atome[particle_found] = value
    play_proc = play_end_proc
    anim_proc = animation_end_proc
    instance_exec({ @atome[particle_found] => value }, &play_proc) if play_proc.is_a?(Proc)
    instance_exec({ @atome[particle_found] => value }, &anim_proc) if anim_proc.is_a?(Proc)
  end

end

def animation(params = {}, &proc)
  grab(:view).animation(params, &proc)
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
      atome_found = grab(target)
      atome_id = atome_found.atome[:id]
      mass = 1
      damping_ratio = 1
      stiffness = 1000
      velocity = 1
      repeat= 1
      ease= 'spring'
      duration = atome_hash[:duration]
      atome_hash[:start].each do |particle_found, start_value|
        end_value = atome_hash[:end][particle_found]
        AtomeJS.JS.animate(particle_found, duration,damping_ratio,ease, mass,  repeat,stiffness, velocity,
                           start_value, end_value, atome_id, atome_found)
      end
    end
  end
end

box({ id: :my_box, drag: true })
c = circle({ id: :the_circle, drag: { move: true, inertia: true, lock: :start } })

Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
aa = animation({
                 targets: [:my_box, :the_circle],
                 start: {
                   left: 0,
                   # smooth: 0

                 },
                 end: {
                   left: 400,
                   # smooth: 100

                 },
                 duration: 2000
               }) do  |pa|
  puts  "animation say#{pa}"
end
# alert aa.targets
aa.play(true) do |po|
  puts "play say #{po}"
end

s = c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow, parents: [:the_circle], children: [],
               left: 3, top: 9, blur: 19,
               red: 0, green: 0, blue: 0, alpha: 1
             })
# alert aa

