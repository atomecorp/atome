# frozen_string_literal: true

# toolbox   method here
class Atome
  private

  def collapse
    @atome.each do |element, value|
      send(element, value) unless element == :type
    end
  end

  def security_pass(_element, _value)
    true
  end

  def sanitize(element, params)
    bloc_found = Universe.get_sanitizer_method(element)
    params = instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
    params
  end

  def identity_generator
    { date: Time.now, location: geolocation }
  end

  def history(property, value)
    "historize : #{property} #{value}"
  end

  def broadcasting(altered_particle, value)
    @broadcast.each_value do |particle_monitored|
      if particle_monitored[:particles].include?(altered_particle)
        code_found=particle_monitored[:code]
        instance_exec(self, altered_particle, value, &code_found) if code_found.is_a?(Proc)
      end
    end
  end

  public

  def monitor(params=nil, &proc_monitoring)
    if params
      atome[:monitor] ||= {}
      params[:atomes].each do |atome_id|
        target_broadcaster = grab(atome_id).instance_variable_get('@broadcast')
        monitor_id = params[:id] || "monitor#{target_broadcaster.length}"
        atome[:monitor] [monitor_id]=params.merge({code: proc_monitoring})
        target_broadcaster[monitor_id] = { particles: params[:particles], code:  proc_monitoring }
      end
    else
      atome[:monitor]
    end

  end

  def store_code_bloc(element, &user_proc)
    # TODO : maybe we have to change tis code if we need multiple proc for an particle
    Object.attr_accessor "#{element}_code"

    instance_variable_set("@#{element}_code", user_proc)
  end


  def particles(particles_found = nil)
    if particles_found
      particles_found.each do |particle_found, value_found|
        atome[particle_found] = value_found
      end
    else
      atome
    end
  end

  def <<(particle)
    value = particle.value
    real_atome[property] << value
  end

  def refresh
    collapse
  end
end
