# frozen_string_literal: true

# toolbox   method here
require 'json'

class Atome
  class << self

    def file_handler(parent, content, bloc)
      grab(parent).instance_exec(content, &bloc)
    end

    def controller_sender(message)
      return if $host == :html

      json_msg = message.to_json
      js_json_msg = json_msg.inspect
      js_command = "atomeJS.controller_sender(#{js_json_msg})"
      JS.eval(js_command)
    end

    # def global_monitoring(instance, methods_to_monitor, variables_to_monitor)
    #   methods_to_monitor.each do |methode|
    #     original_method = instance.method(methode)
    #     instance.define_singleton_method(methode) do |*args, &block|
    #       value_before = instance.instance_variable_get("@#{methode}")
    #       result = original_method.call(*args, &block)
    #       value_after = instance.instance_variable_get("@#{methode}")
    #       if args.empty?
    #         # "read monitoring: #{methode}"
    #       elsif value_before != value_after
    #         affect.each do |targeted_atome|
    #           # get the content of the affect instance_variable and send it
    #           # to the affect method to apply the atome to all atome children
    #           grab(targeted_atome).render(:apply, self)
    #         end
    #       end
    #       result
    #     end
    #   end
    #   variables_to_monitor.each do |var|
    #     instance.define_singleton_method(var) do
    #       instance_variable_get("@#{var}")
    #     end
    #     instance.define_singleton_method("#{var}=") do |value|
    #       instance_variable_set("@#{var}", value)
    #     end
    #   end
    # end

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
    new_atome.each do |element, value|
      send(element, value)
    end
  end

  def particle_main(element, params, &user_proc)
    # TODO : optimise below removing all conditions if possible
    if Atome.instance_variable_get("@main_#{element}").is_a?(Proc) # post is before rendering and broadcasting
      result = instance_exec(params, user_proc, self, &Atome.instance_variable_get("@main_#{element}"))
      params = result if result && !result.instance_of?(Atome)
    end
    params
  end

  def particle_read(element, params, &user_proc)
    if Atome.instance_variable_get("@read_#{element}").is_a?(Proc) # post is before rendering and broadcasting
      params = instance_exec(params, user_proc, self, &Atome.instance_variable_get("@read_#{element}"))
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

  def atome_sanitizer(element, params, &user_proc)
    # Attention: the method is the same as the one used for the partcicle
    particle_sanitizer(element, params)
  end

  def atome_post_process(element, params, new_atome, &user_proc)

    return unless Atome.instance_variable_get("@post_#{element}").is_a?(Proc)

    new_atome.instance_exec(params, user_proc, &Atome.instance_variable_get("@post_#{element}"))

  end

  def atome_processor(element, params, &user_proc)
    # TODO: replace with the line below but need extensive testing as it crash some demos ex: animation
    params = atome_common(element, params)

    atome_pre_process(element, params, &user_proc)

    new_atome = send("set_#{element}", params, &user_proc) # it call  Atome.define_method "set_#{element}" in  new_atome method
    # TODO : check if we don't have a security issue allowing atome modification after creation
    # if we have one find another solution the keep this facility
    atome_post_process(element, params, new_atome, &user_proc)

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

  # def broadcasting(element)
  #   params = instance_variable_get("@#{element}")
  #   @broadcast.each_value do |particle_monitored|
  #     if particle_monitored[:particles].include?(element)
  #       code_found = particle_monitored[:code]
  #       instance_exec(self, element, params, &code_found) if code_found.is_a?(Proc)
  #     end
  #   end
  # end

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
      # instance_exec(@callback[element], proc_found)if proc_found.is_a? Proc
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

  def atome
    # allow to get all atomes instance variables available as a Hash
    instance_variables.each_with_object({}) do |var, hash|
      hash[var[1..-1].to_sym] = instance_variable_get(var) # var[1..-1] enlève le '@' au début
    end
  end

  def to_hash
    hash = {}
    instance_variables.each do |var|
      next if %i[@html_object @history].include?(var)

      hash[var.to_s.delete('@').to_sym] = instance_variable_get(var)
    end
    hash
  end

  def refresh
    particles_found = to_hash
    particles_found.each do |particle_found, value_found|
      send(particle_found, value_found)
    end

  end

  def each(&proc)
    collect.each do |val|
      instance_exec(val, &proc) if proc.is_a?(Proc)
    end
  end

  def <<(item)
    collect << item
  end

  def include?(value)
    include?(value)
  end

  def set(params)
    params.each do |particle, value|
      send(particle, value)
    end
  end

  def detach_atome(atome_id_to_detach)
    atome_to_detach = grab(atome_id_to_detach)
    # TODO: remove the condition below and find why it try to detach an atome that doesn't exist
    nil unless atome_to_detach
  end

  def debug(msg)
    puts msg
  end

  def set_current_user(user_id)
    if Universe.users[user_id]
      Universe.current_user = user_id
    else
      debug "#{user_id} not found"
    end
  end

  def remove_layout
    display(:default)
    # we get the current parent (the previous layout)
    parent_found = grab(attach)
    # we get the parent of the parent
    grand_parent = parent_found.attach
    # and attach the item to the grand parent
    # we remove the parent category and restore atome category
    remove({ category: attach })
    category(:atome)
    attach(grand_parent)
    #  we delete the parent (the layout) if it no more children attached
    if parent_found.attached.length == 0
      parent_found.delete(true)
    end
  end

end
