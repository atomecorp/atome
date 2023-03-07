# frozen_string_literal: true

# toolbox   method here
class Atome
  private

  def collapse
    @atome.each do |element, value|
      send(element, value)
    end
  end

  def security_pass(_element, _value)
    true
  end

  def sanitize(element, params, &user_proc)
    bloc_found = Universe.get_sanitizer_method(element)
    params = instance_exec(params, user_proc, &bloc_found) if bloc_found.is_a?(Proc)
    params
  end

  def history(property, value)
    "historize : #{property} #{value}"
  end

  def broadcasting(element)
    params = instance_variable_get("@#{element}")
    @broadcast.each_value do |particle_monitored|
      if particle_monitored[:particles].include?(element)
        code_found = particle_monitored[:code]
        instance_exec(self, element, params, &code_found) if code_found.is_a?(Proc)
      end
    end
  end

  public

  def monitor(params = nil, &proc_monitoring)
    if params
      monitoring = atome[:monitor] ||= {}
      params[:atomes].each do |atome_id|
        target_broadcaster = grab(atome_id).instance_variable_get('@broadcast')
        monitor_id = params[:id] || "monitor#{target_broadcaster.length}"
        monitoring[monitor_id] = params.merge({ code: proc_monitoring })
        target_broadcaster[monitor_id] = { particles: params[:particles], code: proc_monitoring }
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

  def add_to_integer(_atome_found, _particle_found, &_user_proc)
    puts "there's no interest to add anything to an integer!"
  end

  def add_to_float(_atome_found, _particle_found, &_user_proc)
    puts "there's no interest to add anything to an integer!"
  end

  def add_to_bignum(_atome_found, _particle_found, &_user_proc)
    puts "there's no interest to add anything to an integer!"
  end

  def add_to_string(_atome_found, _particle_found, &_user_proc)
    puts "there's no interest to add anything to an string!"
  end

  def add_to_hash(particle, values, &user_proc)
    @atome[:add][particle] = true
    # we update  the holder of any new particle if user pass a bloc
    store_code_bloc(particle, &user_proc) if user_proc
    values.each do |value_id, value|
      @atome[particle][value_id] = value
    end
  end

  def add_to_array(particle, value, &_user_proc)
    @atome[:add][particle] = true
    # we update  the holder of any new particle if user pass a bloc
    @atome[particle] << value
  end

  def add_to_atome(atome_type, particle_found, &user_proc)
    # puts "-----> atome_type : #{atome_type}, particle_found : #{particle_found}"
    # @atome[:add] = [] unless @atome[:add]
    @atome[:add][atome_type] = particle_found
    send(atome_type, particle_found, &user_proc)
  end

  def add(particles, &user_proc)
    # alert particles
    @atome[:add] = {} unless @atome[:add]
    # @atome[:add] << particles
    particles.each do |particle, value|
      particle_type = Universe.particle_list[particle] || 'atome'
      send("add_to_#{particle_type}", particle, value, &user_proc)
    end
  end

  def substract(particles, &user_proc)
    # TODO : write code here to remove add elements"
    puts "write code here to remove add elements"
    # @atome[:add]=:poi
    # particles.each do |particle, value|
    #   particle_type = Universe.particle_list[particle] || 'atome'
    #   puts "<<<<<< this the place to b ....>>>>>>#{particles} #{particle_type}"
    #   send("add_to_#{particle_type}", particle, value, &user_proc)
    # end
  end

  def refresh
    collapse
  end

  def collector(params = {}, &bloc)
    atome_type = :collector
    generated_render = params[:renderers] || []
    generated_id = params[:id] || identity_generator(atome_type)

    generated_parents = params[:parents] || [id.value]
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    Batch.new({ atome_type => params }, &bloc)
  end

  def each(&proc)
    value.each do |val|
      instance_exec(val, &proc) if proc.is_a?(Proc)
    end
  end

  def include?(value)
    self.value.include?(value)
  end

  def each_with_index(*args, &block)
    value.each_with_index(&block)
  end

  def [](range)
    if instance_of?(Atome)
      value[range]
      # elsif value[range].instance_of?(Atome)
      #   return value[range]
    elsif value[range].instance_of?(Array)
      collector_object = Object.collector({})
      collected_atomes = []
      value[range].each do |atome_found|
        collected_atomes << atome_found
      end
      collector_object.data(collected_atomes)

      return collector_object
    end

  end

  def []=(params, value)
    # TODO : it may miss some code, see above
    self.value[params] = value
  end

  def set(params)
    params.each do |particle, value|
      send(particle, value)
    end
  end

  def particle_to_remove_decision(particle_to_remove)
    if particle_to_remove.instance_of? Hash
      particle_to_remove.each do |particle_found, value|
        send("remove_#{particle_found}", value)
      end
    else
      send(particle_to_remove, 0)
    end
  end

end
