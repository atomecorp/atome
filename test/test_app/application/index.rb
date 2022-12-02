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
# TODO : animate from actual position to another given position
# TODO : keep complex property when animating (cf shadows)

##### animation #####

generator = Genesis.generator

generator.build_atome(:animation)
generator.build_particle(:targets)
generator.build_particle(:start)
generator.build_option(:pre_render_start) do |_value, user_proc|
  @animation_start_proc = user_proc
end
generator.build_particle(:stop)
generator.build_option(:pre_render_stop) do |_value, user_proc|
  @animation_stop_proc = user_proc
end
generator.build_particle(:begin)
generator.build_particle(:end)
generator.build_particle(:duration)
generator.build_particle(:mass)
generator.build_particle(:damping)
generator.build_particle(:stiffness)
generator.build_particle(:velocity)
generator.build_particle(:repeat)
generator.build_particle(:ease)

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
  def browser_animate_callback(particle_found, value, animation_hash, original_particle, animation_atome)
    anim_proc = animation_hash[:code]
    #  we exec the callback bloc from :animate
    instance_exec({ original_particle => value }, &anim_proc) if anim_proc.is_a?(Proc)
    # we exec the callback bloc from :play
    play_proc = animation_atome.play_active_proc
    instance_exec({ @atome[particle_found] => value }, &play_proc) if play_proc.is_a?(Proc)
    # we animate:
    browser_object.style[particle_found] = value if browser_object
    # we update the atome property
    @atome[original_particle] = value
  end

  def play_start_callback(particle_found, startvalue, animation_hash, original_particle, atome_found)
    value = animation_hash[:begin][original_particle]
    value = atome_found.atome[original_particle] if value == :self
    start_proc = @animation_start_proc
    @atome[original_particle] = value
    instance_exec({ original_particle => value }, &start_proc) if start_proc.is_a?(Proc)
  end

  def play_stop_callback(particle_found, end_value, animation_hash, original_particle, atome_found)
    value = animation_hash[:end][original_particle]
    end_proc = @animation_stop_proc
    @atome[original_particle] = value
    instance_exec({ original_particle => value }, &end_proc) if end_proc.is_a?(Proc)
  end

end

def animation(params = {}, &proc)
  grab(:view).animation(params, &proc)
end

module BrowserHelper

  def self.anim_convertor(value)
    { left: [:left, "#{value}px"], right: [:right, "#{value}px"], top: [:top, "#{value}px"],
      bottom: [:bottom, "#{value}px"], smooth: ['border-radius', "#{value}px"],
      left_add: ['transform', "translateX(#{value}px)"],
      right_add: ['transform', "translateY(#{value}px)"],
      width: [:width, "#{value}px"], heigh: [:heigh, "#{value}px"]
    }
  end

  def self.anim_value_analysis(value, particle_found, atome_found)
    case value
    when :self
      # this case mean the user use the current atome so we get the particle value of the atome
      value = atome_found.atome[particle_found]
    when Integer
      value
    else
      # this case mean the user try to pass an id so we get the particle value of the atome
      value = grab(value).atome[particle_found]
      value
    end
    value
  end

  def self.send_anim_to_js(animation, atome_hash, atome_found, atome_id, animation_atome)
    animated_particle = animation[0]
    start_value = animation[1]
    end_value = animation[2]
    original_particle = animation[3]
    AtomeJS.JS.animate(animated_particle, atome_hash[:duration], atome_hash[:damping], atome_hash[:ease],
                       atome_hash[:mass], atome_hash[:repeat], atome_hash[:stiffness], atome_hash[:velocity],
                       start_value, end_value, atome_id, atome_found, atome_hash, original_particle, animation_atome)
  end

  def self.sanitize_anim_params(value, particle_found, atome_hash, atome_found, atome_id, animation_atome)
    start_value = anim_value_analysis(value, particle_found, atome_found)
    start_value = BrowserHelper.anim_convertor(start_value)[particle_found][1]
    end_value = anim_value_analysis(atome_hash[:end][particle_found], particle_found, atome_found)
    end_value = BrowserHelper.anim_convertor(end_value)[particle_found][1]
    animated_particle = BrowserHelper.anim_convertor(value)[particle_found][0]
    # animation is a stupid array to satisfy rubocop stupidity
    animation = [animated_particle, start_value, end_value, particle_found]
    send_anim_to_js(animation, atome_hash, atome_found, atome_id, animation_atome)
  end

  def self.anim_pop_motion_converter(atome_hash, atome_found, atome_id, animation_atome)
    atome_hash[:dampingRatio] = atome_hash.delete(:damping)
    atome_hash[:begin].each do |particle_found, value|
      sanitize_anim_params(value, particle_found, atome_hash, atome_found, atome_id, animation_atome)
    end
  end

  def self.begin_animation(atome_hash, atome_found, atome_id, animation_atome)
    anim_pop_motion_converter(atome_hash, atome_found, atome_id, animation_atome)
  end

  def self.browser_play_animation(options, browser_object_found, atome_hash, animation_atome, proc)
    atome_hash[:targets] = [:eDen] unless atome_hash[:targets]
    animation_atome.play_active_proc = proc
    atome_hash[:targets].each do |target|
      atome_found = grab(target)
      atome_id = atome_found.atome[:id]
      begin_animation(atome_hash, atome_found, atome_id, animation_atome)
    end

  end
end

# verif

bb = box({ id: :the_ref, width: 369 })
bb.color(:red)
box({ id: :my_box, drag: true })
c = circle({ id: :the_circle, left: 222, drag: { move: true, inertia: true, lock: :start } })
c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow,
           parents: [:the_circle], children: [],
           left: 3, top: 9, blur: 19,
           red: 0, green: 0, blue: 0, alpha: 1
         })
# alert aa

Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
aa = animation({
                 targets: %i[my_box the_circle],
                 begin: {
                   left_add: 0,
                   top: :self,
                   smooth: 0,
                   width: 3
                 },
                 end: {
                   left_add: 333,
                   top: 299,
                   smooth: 33,
                   width: :the_ref
                 },
                 duration: 800,
                 mass: 1,
                 damping: 1,
                 stiffness: 1000,
                 velocity: 1,
                 repeat: 1,
                 ease: 'spring'
               }) do |pa|
  puts "animation say#{pa}"
end
aa.stop(true) do |val|
  puts " stop : #{val}"
end

aa.start(true) do |val|
  puts " start : #{val}"
end

bb.touch(true) do
  aa.play(true) do |po|
    # puts "play say #{po}"
  end
end

aaa = animation({
                  # targets: %i[],
                  begin: {
                    left_add: 0,
                    top: :self,
                    smooth: 0,
                    width: 3
                  },
                  end: {
                    left_add: 333,
                    top: :self,
                    smooth: 33,
                    width: :the_ref
                  },
                  duration: 8800,
                  mass: 1,
                  damping: 1,
                  stiffness: 1000,
                  velocity: 1,
                  repeat: 1,
                  ease: 'spring'
                }) do |pa|
  puts "get params to do anything say#{pa}"
end
wait 1 do
  # aaa.play(true) do |po|
  #   puts "play aaa say #{po}"
  # end
  # alert Universe.atomes.keys
end

# alert aa.targets

generator = Genesis.generator
generator.build_particle(:sort) do |_value, sort_proc|
  @sort_proc=sort_proc
end

generator.build_render_method(:browser_sort) do |options, _proc|
  AtomeJS.JS.sort(options, @atome[:id], self)
end


class Atome
  def sort_callback(atome)
    sort_proc = @sort_proc
    instance_exec(atome, &sort_proc) if sort_proc.is_a?(Proc)
  end

end
