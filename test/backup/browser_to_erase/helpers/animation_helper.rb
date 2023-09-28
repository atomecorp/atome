# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.anim_convertor(value)
    { left: [:left, "#{value}px"], right: [:right, "#{value}px"], top: [:top, "#{value}px"],
      bottom: [:bottom, "#{value}px"], smooth: ['border-radius', "#{value}px"],
      left_add: ['transform', "translateX(#{value}px)"],
      right_add: ['transform', "translateY(#{value}px)"],
      width: [:width, "#{value}px"], height: [:height, "#{value}px"] }
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
    atome_js.JS.animate(animated_particle, atome_hash[:duration], atome_hash[:damping], atome_hash[:ease],
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

  def self.browser_play_animation(_options, _browser_object, atome_hash, animation_atome, proc)
    atome_hash[:targets] = [:eDen] unless atome_hash[:targets]
    animation_atome.play_active_proc = proc
    atome_hash[:targets].each do |target|
      atome_found = grab(target)
      atome_id = atome_found.atome[:id]
      begin_animation(atome_hash, atome_found, atome_id, animation_atome)
    end
  end
end
