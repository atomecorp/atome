# frozen_string_literal: true

# toolbox   method here
class Atome

  # local server messaging
  def self.controller_sender(message)
    return if $host == :html

    json_msg = message.to_json
    atome_js.JS.controller_sender(json_msg)

  end

  def response_listener(hashed_msg)
    js_action = hashed_msg.JS[:action]
    js_body = hashed_msg.JS[:body]
    send(js_action, js_body)
  end

  def self.controller_listener

    return if $host == :browser

    atome_js.JS.controller_listener() # js folder atome/helipers/atome/communication

  end

  def collapse

    # TODO : try to optimise the two lines below to avoid conditions
    @atome[:unit] = {} unless @atome[:unit]
    @atome[:security] = {} unless @atome[:security]
    @atome.each do |element, value|
      send(element, value)
    end
  end

  def authorise(password, destroy = true)
    @temps_authorisation = [password, destroy]
  end

  def write_auth(element)
    # puts "===+> #{security}"
    if security[element]
      password_found = @temps_authorisation[0]
      authorisation = Black_matter.check_password(password_found, Black_matter.password)
      password_destruction = @temps_authorisation[1]
      @temps_authorisation = [nil, true] if password_destruction
      return true if authorisation
      false
    else
      true
    end
  end

  def read_auth(element)
    if @security[element]
      password_found = @temps_authorisation[0]
      authorisation = Black_matter.check_password(password_found, Black_matter.password)
      password_destruction = @temps_authorisation[1]
      @temps_authorisation = [nil, true] if password_destruction
      true if authorisation
    else
      true
    end
  end

  def particle_sanitizer(element, params, &user_proc)
    bloc_found = Universe.get_sanitizer_method(element)
    # sanitizer occurs before any treatment
    params = instance_exec(params, user_proc, &bloc_found) if bloc_found.is_a?(Proc)
    params
  end

  def atome_pre_process(element, params, &user_proc)
    params = particle_sanitizer(element, params)

    # TODO: replace with the line below but need extensive testing as it crash some demos ex: animation
    params = atome_common(element, params)
    if Atome.instance_variable_get("@pre_#{element}").is_a?(Proc)
      instance_exec(params, self, user_proc, &Atome.instance_variable_get("@pre_#{element}"))
    end

    new_atome = send("set_#{element}", params, &user_proc) # it call  Atome.define_method "set_#{element}" in  new_atome method
    # TODO : check if we don't have a security issue allowing atome modification after creation
    # if we have one find another solution the keep this facility
    if Atome.instance_variable_get("@post_#{element}").is_a?(Proc)
      instance_exec(params, new_atome, user_proc, &Atome.instance_variable_get("@post_#{element}"))
    end
    new_atome
  end

  def history(filter = {})
    filter[:id] = id
    Universe.story(filter)
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

  def store_proc(element, params = true, &user_proc)
    instance_variable_set("@#{element}_code", {}) unless instance_variable_get("@#{element}_code")
    # TODO : we may have to change this code if we need multiple proc for an particle
    # FIXME : find a better algorithm can be found to avoid test if option is a Hash
    Object.attr_accessor "#{element}_code"
    elem_code = "@#{element}_code"
    if params.instance_of? Hash
      option_found = params.values[0]
      instance_variable_get(elem_code)["#{option_found}_code"] = user_proc
    else
      instance_variable_get(elem_code)[element] = user_proc
    end
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

    real_atome[property] << particle
  end

  def add_to_hash(particle, values, &user_proc)
    @atome[:add][particle] = true
    # we update  the holder of any new particle if user pass a bloc
    store_proc(particle, &user_proc) if user_proc
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
    @atome[:add][atome_type] = particle_found
    send(atome_type, particle_found, &user_proc)
  end

  def add(particles, &user_proc)

    @atome[:add] = {} unless @atome[:add]
    particles.each do |particle, value|
      particle_type = Universe.particle_list[particle] || 'atome'
      send("add_to_#{particle_type}", particle, value, &user_proc)
      # now we remove systematically the added hash so next particle won't be automatically added
      @atome[:add].delete(particle)
    end
  end

  def substract(_particles, &_user_proc)
    # TODO : write code here to remove add elements"
    puts "write code here to remove add elements"
  end

  def refresh
    collapse
  end

  def each(&proc)
    value.each do |val|
      instance_exec(val, &proc) if proc.is_a?(Proc)
    end
  end

  def include?(value)
    self.include?(value)
  end

  def each_with_index(*_args, &block)
    value.each_with_index(&block)
  end

  def [](range)
    if instance_of?(Atome)
      value[range]
    elsif value[range].instance_of?(Array)
      Batch.new(value[range])
      # return collector_object
    end

  end

  def []=(params, value)
    # TODO : it may miss some code, see above
    self[params] = value
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

  # def physical
  #   # TODO :  automatise materials type list when creating a new atome it should be specified if material or not
  #   types = %i[texts images videos shapes wwws]
  #   atomes_found = []
  #   types.each do |type|
  #     ids_found = atome[type]
  #     next unless ids_found
  #
  #     ids_found.each do |id_found|
  #       atomes_found << id_found
  #     end
  #   end
  #   atomes_found
  # end

  def detach_atome(atome_id_to_detach)
    atome_to_detach = grab(atome_id_to_detach)
    # TODO: remove the condition below and find why it try to detach an atome that doesn't exist
    nil unless atome_to_detach
  end

  def debug(msg)
    # add id-f debug mode
    puts msg
  end

  def set_current_user(id)
    if Universe.users[id]
      Universe.current_user = id
    else
      debug "#{id} not found"
    end
  end
end
