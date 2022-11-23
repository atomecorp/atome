# frozen_string_literal: true

# toolbox   method here
class Atome
  private

  def collapse
    type(@atome[:type])
  end

  def a_render
    @atome.each do |element, value|
      send(element, value) unless element == :type
    end
  end

  def security_pass(_element, _value)
    true
  end

  def particle_sanitizer(_element, params)
    params
  end

  def atome_sanitizer(element, params)
    send("sanitize_#{element}", params)
  end

  def sanitize_particle(element, value, &user_proc)
    value = particle_sanitizer(element, value)
    create_particle(element, value, &user_proc)
  end

  def identity_generator
    { date: Time.now, location: geolocation }
  end

  def broadcasting(element, value)
    return unless @broadcast[:particles]&.include?(element)

    bloc_found = @broadcast[:bloc]
    instance_exec(self, element, value, &bloc_found) if bloc_found.is_a?(Proc)
  end

  def history(property, value)
    "historize : #{property} #{value}"
  end

  public

  def monitor(params, &proc_monitoring)
    params[:atomes].each do |atome_id|
      grab(atome_id).instance_variable_set('@broadcast', { particles: params[:particles], bloc: proc_monitoring })
    end
  end

  def <<(particle)
    value = particle.value
    real_atome[property] << value
  end
end
