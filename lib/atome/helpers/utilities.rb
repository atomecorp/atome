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

    # monitoring system
    def monitoring(atomes_to_monitor, particles_to_monitor, &bloc)
      atomes_to_monitor.each do |atome_to_monitor|
        particles_to_monitor.each do |monitored_particle|
          # Store original method
          original_method = atome_to_monitor.method(monitored_particle)

          # redefine method
          atome_to_monitor.define_singleton_method(monitored_particle) do |*args, &proc|

            # Monitor before calling original method
            value_before = atome_to_monitor.instance_variable_get("@#{monitored_particle}")
            if args.empty?
              args = nil
            else
              if monitored_particle == :touch
                instance_variable_set("@#{monitored_particle}", { tap: args[0] })
                instance_variable_set("@#{monitored_particle}_code", { touch: proc })

                args = { tap: args[0] }
              else
                instance_variable_set("@#{monitored_particle}", args[0])
              end
              args = args[0]
            end
            instance_exec({ original: value_before, altered: args, particle: monitored_particle }, &bloc) if bloc.is_a?(Proc)
            original_method.call(*args)
          end
        end
      end
    end

  end

  def help(particle, &doc)
    if doc
      Universe.set_help(particle, &doc)
    else
      doc_found = Universe.get_help(particle)
      instance_exec(&doc_found) if doc_found.is_a?(Proc)
    end
  end

  def example(particle, &example)
    if example
      Universe.set_example(particle, &example)
    else
      example_found = Universe.get_example(particle)
      instance_exec(&example_found) if example_found.is_a?(Proc)
    end
  end

  # local server messaging
  def file_for_opal(parent, bloc)
    JS.eval("fileForOpal('#{parent}', #{bloc})")
  end

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
    # if params.instance_of? Hash
    #   option_found = params.values[0]
    #   instance_variable_get(elem_code)["#{option_found}_code"] = user_proc
    # else
      instance_variable_get(elem_code)[element] = user_proc
    # end
  end

  # ###################### new 1
  # def store_proc(element, params = true, &user_proc)
  #   instance_variable_set("@#{element}_code", {}) unless instance_variable_get("@#{element}_code")
  #   # TODO : we may have to change this code if we need multiple proc for an particle
  #   # FIXME : find a better algorithm can be found to avoid test if option is a Hash
  #   Object.attr_accessor "#{element}_code"
  #   elem_code = "@#{element}_code"
  #   if params.instance_of? Hash
  #     option_found = params.values[0]
  #     puts "#{instance_variable_get(elem_code)["#{option_found}_code"]}"
  #     proc_stored= instance_variable_get(elem_code)["#{option_found}_code"] = []
  #     # proc_stored=[]
  #   else
  #     proc_stored= instance_variable_get(elem_code)[element] = []
  #   end
  #   proc_stored << user_proc
  #   # the commented line below will automatically execute the callback method
  #   # we keep it commented because sometime the execution is conditioned, ex : run callbck on a touch
  #   # send("#{element}_callback")
  # end
  # ##################### new 1

  # This method is used to automatically create a callback method suffixed by '_callback'. For example: shell => shell_callback.
  # it can be override if you create a method like:
  # new({callback: :shell}) do |params, bloc|
  # # …write what you want …
  # end
  def particle_callback(element)
    Atome.define_method("#{element}_callback") do |return_params|
      # we test if instance_variable_get("@#{element}_code") is a hash for the can se the particle value is a hash
      proc_found = if instance_variable_get("@#{element}_code").instance_of? Hash
                     # Then we get the first item of the hash because the proc is attached to it
                     instance_variable_get("@#{element}_code").values.first
                     # instance_exec(@callback[element], proc_found)if proc_found.is_a? Proc
                   else
                     instance_variable_get("@#{element}_code")[element]
                     # instance_exec(@callback[element], proc_found)if proc_found.is_a? Proc
                            end
      # array_of_proc_found.each do |proc_found|
        proc_found.call(return_params) if proc_found.is_a? Proc
      # end if array_of_proc_found

      # if array_of_proc_found
      #   proc_found= array_of_proc_found.shift
      #   proc_found.call(return_params) if proc_found.is_a? Proc
      # end

    end
  end

  # this method generate the method accessible for end developers
  # it's the send the method define in "particle_callback"
  def callback(element, return_params = nil)
    send("#{element}_callback", return_params)
  end

  # def callback(data)
  #   @callback[data.keys[0]] = data[data.keys[0]]
  # end

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

  def each_with_index(&proc)
    index = 0
    collect.each do |val|
      instance_exec(val, index, &proc) if proc.is_a?(Proc)
      index += 1
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

  def server(server_params = nil)
    if server_params
      @current_server = server_params
    else
      @current_server
    end
  end

  def server_receiver(params)
    # alert params
    # alert message_code
    calllbacks_found= instance_variable_get('@message_code')
    # we delete the default message created by atome
    calllbacks_found.delete(:message)
    # we get the oldest available callback, to treat it
    oldest_callback = calllbacks_found.delete(calllbacks_found.keys.first)
    oldest_callback.call(params) if oldest_callback.is_a? Proc
    # callback(:message, params)
  end

  def init_websocket
    instance_variable_set('@message_code', {})
    connection(server)
  end

  def init_database # this method is call from JS (atome/communication)
    message({ action: :init_db, value: { atome: {}, particles: {} } })
  end

  def encrypt(string)
    # if RUBY_ENGINE.downcase == 'opal' || 'wasm32-wasi'
    # `sha256(#{string})`
    js_code = "sha256('#{string}')"
    JS.eval(js_code)
    # else
    # Digest::SHA256.hexdigest(string)
    # end
  end
end



