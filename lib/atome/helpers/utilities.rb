# frozen_string_literal: true

# toolbox   method here
class Atome
  class << self
    def controller_sender(message)
      return if $host == :html
      json_msg = message.to_json
      atome_js.JS.controller_sender(json_msg)
    end

    def global_monitoring(instance, methods_to_monitor, variables_to_monitor)
      methods_to_monitor.each do |methode|
        original_method = instance.method(methode)
        instance.define_singleton_method(methode) do |*args, &block|
          value_before = instance.instance_variable_get("@#{methode}")
          result = original_method.call(*args, &block)
          value_after = instance.instance_variable_get("@#{methode}")
          if args.empty?
            # "read monitoring: #{methode}"
          elsif value_before != value_after
            affect.each do |targeted_atome|
              # get the content of the affect instance_variable and send it
              # to the affect method to apply the atome to all atome children
              grab(targeted_atome).render(:apply, self)
            end
            # puts "monitoring #{value_before} to #{value_after}"
          else
            # "monitoring: call #{methode} without modification"
          end
          result
        end
      end
      variables_to_monitor.each do |var|
        instance.define_singleton_method(var) do
          # puts "read monitoring of : #{var}"
          instance_variable_get("@#{var}")
        end
        instance.define_singleton_method("#{var}=") do |value|
          # puts "write monitoring of : #{var}"
          instance_variable_set("@#{var}", value)
        end
      end
    end

  end

  # local server messaging

  def response_listener(hashed_msg)
    js_action = hashed_msg.JS[:action]
    js_body = hashed_msg.JS[:body]
    send(js_action, js_body)
  end

  def self.controller_listener

    return if $host == :html

    atome_js.JS.controller_listener() # js folder atome/helipers/atome/communication

  end

  def collapse(new_atome)
    # TODO : try to optimise the two lines below to avoid conditions
    # new_atome[:unit] = {} unless unit
    # new_atome[:security] = {} unless new_atome[:security]
    new_atome.each do |element, value|
      send(element, value)
    end

  end

  def authorise(password, destroy = true)
    @temps_authorisation = [password, destroy]
  end

  def write_auth(element)
    if @security[element]
      password_found = @temps_authorisation[0]
      authorisation = Black_matter.check_password(password_found, Black_matter.password)
      password_destruction = @temps_authorisation[1]
      @temps_authorisation = [nil, true] if password_destruction
      return true if authorisation
      false
    else
      true
    end
    true
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
    true
  end

  def particle_main(element, params, &user_proc)
    # TODO : optimise below removing all conditions if possible
    if Atome.instance_variable_get("@main_#{element}").is_a?(Proc) # post is before rendering and broadcasting
      result = instance_exec(params, user_proc, self, &Atome.instance_variable_get("@main_#{element}"))
      params = result if result && !result.instance_of?(Atome)
    end
    params
  end

  def particle_sanitizer(element, params, &user_proc)
    bloc_found = Universe.get_sanitizer_method(element)
    # sanitizer occurs before any treatment
    # it's call at the very start when a new atome is created : in genesis.rb /new_atome
    # it's also call when creating a new particle in genesis/ new_particle befre creating the particle
    # and also before creating additional method  in genesis/ additional_particle_methods
    params = instance_exec(params, user_proc, &bloc_found) if bloc_found.is_a?(Proc)
    params
  end

  def particle_pre(element, params, &user_proc)
    if Atome.instance_variable_get("@pre_#{element}").is_a?(Proc) # post is before rendering and broadcasting
      params = instance_exec(params, user_proc, self, &Atome.instance_variable_get("@pre_#{element}"))
    end
    params
  end

  def particle_post(element, params, &user_proc)
    if Atome.instance_variable_get("@post_#{element}").is_a?(Proc) # post is after rendering and broadcasting
      params = instance_exec(params, user_proc, self, &Atome.instance_variable_get("@post_#{element}"))
    end
    params
  end

  def particle_after(element, params, &user_proc)
    if Atome.instance_variable_get("@after_#{element}").is_a?(Proc) # after is post saving
      params = instance_exec(params, user_proc, self, &Atome.instance_variable_get("@after_#{element}"))
    end
    params
  end

  def atome_pre_process(element, params, &user_proc)
    if Atome.instance_variable_get("@pre_#{element}").is_a?(Proc)
      params = instance_exec(params, self, user_proc, &Atome.instance_variable_get("@pre_#{element}"))
    end
    params
  end

  def atome_post_process(element, params,new_atome, &user_proc)

    if Atome.instance_variable_get("@post_#{element}").is_a?(Proc)
      new_atome.instance_exec(params, user_proc, &Atome.instance_variable_get("@post_#{element}"))
    end
  end

  def atome_processor(element, params, &user_proc)

    # TODO: replace with the line below but need extensive testing as it crash some demos ex: animation
    params = atome_common(element, params)
    atome_pre_process(element, params, &user_proc)
    new_atome = send("set_#{element}", params, &user_proc) # it call  Atome.define_method "set_#{element}" in  new_atome method
    # TODO : check if we don't have a security issue allowing atome modification after creation
    # if we have one find another solution the keep this facility
    atome_post_process(element, params,new_atome, &user_proc)
    new_atome
  end

  def store(params)
    params.each do |particle_to_save, data|
      # @!atome[particle_to_save]=data
      # instance_variable_set(particle_to_save,data)
    end

  end

  def history(filter = {})
    filter[:id] = @id
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
    # the commented line below will automatically execute the callback method
    # we keep it commented because sometime the execution is conditioned, ex : run callbck on a touch
    # send("#{element}_callback")
  end

  # this method is used to automatically create a callback method  sufifxed par '_callbback' ex :.shell => shell_callback
  # it can be override if you create a method like:
  # new({callback: :shell}) do |params, bloc|
  # # …write what you want …
  # end
  def particle_callback(element)
    Atome.define_method "#{element}_callback" do
      proc_found = instance_variable_get("@#{element}_code")[element]
      proc_found.call(@callback[element]) if proc_found.is_a? Proc
    end
  end

  # this method generate the method accessible for end developers
  # it's the send the method define in "particle_callback"
  def call(element)
    send("#{element}_callback")
  end

  def callback(data)
    @callback[data.keys[0]] = data[data.keys[0]]
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

  # def <<(particle)
  #   alert "ici : #{self} #{particle}"
  #   # instance_variable_get("@#{property}") << particle
  # end

  # def add(particles, &user_proc)
  #
  #   @!atome[:add] = {} unless @!atome[:add]
  #   particles.each do |particle, value|
  #     particle_type = Universe.particle_list[particle] || 'atome'
  #     send("add_to_#{particle_type}", particle, value, &user_proc)
  #     # now we remove systematically the added hash so next particle won't be automatically added
  #     @!atome[:add].delete(particle)
  #   end
  # end
  #
  # def substract(_particles, &_user_proc)
  #   # TODO : write code here to remove add elements"
  #   puts "write code here to remove add elements"
  # end
  def atome
    # allow to get all atomes instance variables available as a Hash
    instance_variables.each_with_object({}) do |var, hash|
      hash[var[1..-1].to_sym] = instance_variable_get(var) # var[1..-1] enlève le '@' au début
    end
  end

  def refresh
    puts "You need to send all instance variable the workflow has changed! "
    collapse(atome_to_hash)
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

  def set_current_user(user_id)
    if Universe.users[user_id]
      Universe.current_user = user_id
    else
      debug "#{user_id} not found"
    end
  end
end
