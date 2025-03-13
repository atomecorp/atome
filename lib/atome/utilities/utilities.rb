# frozen_string_literal: true

# toolbox   method here
require 'json'
# def is_descendant(ancestor, descendant)
#   JS.eval("return isDescendant('#{ancestor}', '#{descendant}')")
# end
class Atome
  class << self
    attr_accessor :initialized

    def sanitize_data_for_json(data)
      data.gsub('"', '\\"')
    end

    def send_localstorage_content
      storage = JS.global[:localStorage]
      storage_array = storage.to_a
      storage_array.each_with_index do |_i, index|
        key = JS.global[:localStorage].key(index)
        sanitize_data_for_json(storage.getItem(key))
      end
    end

    def server_receiver(params)
      callback_found = Universe.messages[params[:message_id]]
      callback_found.call(params) if callback_found.is_a? Proc
    end

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

    # def get_logs
    #   A.view_logs
    # end

    # atome builder
    def preset_builder(preset_name, &bloc)
      # Important : previously def box , def circle
      Universe.preset_list << preset_name
      Object.define_method preset_name do |params = {}, &proc|
        grab(:view).send(preset_name, params, &proc)
      end
      define_method preset_name do |params|
        preset_to_add = instance_exec(params, &bloc) if bloc.is_a? Proc
        if Essentials.default_params[preset_name]
          Essentials.default_params[preset_name].merge(preset_to_add) if preset_to_add
        else
          Essentials.default_params[preset_name] = preset_to_add if preset_to_add
        end
        params = atome_common(preset_name, params)
        preset_common(params, &bloc)
      end

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
            if bloc.is_a?(Proc)
              instance_exec({ original: value_before, altered: args, particle: monitored_particle }, &bloc)
            end
            original_method.call(*args)
          end
        end
      end
    end

    def controller_listener
      return if $host == :html
      atome_js.JS.controller_listener() # js folder atome/helipers/atome/communication
    end

    def handle_svg_content(svg_content, target, id_passed, normalise)
      # alert target
      if normalise== 'true'
        # puts svg_content
        svg_content= A.normalise_svg(svg_content)
      else
        # puts "2 - normalise: #{normalise}"
      end
      # puts svg_content
      atome_content = A.vectoriser(svg_content)
      target_vector = grab(target)
      target_vector.data(atome_content)
      grab(id_passed).instance_variable_get('@svg_to_vector').call({id: id_passed, target: target, content: svg_content})
      # puts svg_content
      # puts '------'
      # sss= A.normalise_svg(svg_content)
      # puts sss
    end


  end

  @initialized = {}

  def grip(role_wanted)
    gripped_atome = []

    fasten.each do |child_id|
      child_found = grab(child_id)
      gripped_atome << child_id if child_found.role && child_found.role.include?(role_wanted)
    end
    gripped_atome
  end

  def recursive(_val)
    # dummy method
  end

  def retrieve(params = {}, &block)
    closest_first = true, include_self = false
    if params[:ascending] == false
      closest_first = :inverted
    end
    if params[:self] == true
      include_self = true
    end

    # this method allow to retrieve all children of an atome recursively, beginning from the closet child or inverted

    all_children = []
    fetch_children_recursively = lambda do |parent, depth|
      children_ids = parent.fasten
      if children_ids.any?
        children_ids.each do |child_id|
          child = grab(child_id)
          fetch_children_recursively.call(child, depth + 1)
        end
      end
      if include_self
        all_children << { depth: depth, child: parent }
      else
        all_children << { depth: depth, child: parent } unless parent == self
      end

    end

    fetch_children_recursively.call(self, 0)

    sorted_children = if closest_first != :inverted
                        all_children.sort_by { |entry| entry[:depth] }
                      else
                        all_children.sort_by { |entry| -entry[:depth] }
                      end

    sorted_children.each do |entry|
      block.call(entry[:child])
    end
  end

  def found_spacing_in_percent(parent_width, child_width, nb_of_children)
    total_child_width = child_width * nb_of_children
    remaining_width = parent_width - total_child_width
    spacing = remaining_width.to_f / (nb_of_children + 1)
    spacing_percentage = (spacing / parent_width) * 100
    spacing_percentage.round(2)
  end

  def block(params)
    direction = params.delete(:direction) || :vertical
    spacing = params.delete(:spacing) || 3
    width_found = params.delete(:width) || '100%'
    height_found = params.delete(:height) || '100%'
    bloc_params = params.delete(:data) || {}

    last_id_found = grip(:block).last

    if last_id_found
      # last_found = grab(last_id_found)
      case direction
      when :vertical
        box({ top: below(last_id_found, spacing), role: :block, width: width_found }.merge(params).merge(bloc_params))
      when :horizontal
        width_found = to_px(:width)
        block_left = after(last_id_found, spacing)
        left_in_percent = (block_left / width_found) * 100
        box({ left: "#{left_in_percent}%", role: :block, height: height_found }.merge(params).merge(bloc_params))
      else
        #
      end
    else
      case direction
      when :vertical
        box({ top: spacing, role: :block, width: width_found }.merge(params).merge(bloc_params))
      when :horizontal
        box({ left: spacing, role: :block, height: height_found }.merge(params).merge(bloc_params))
      else
        #
      end
    end

  end

  def blocks(params)

    blocks = params.delete(:blocks)
    distribute = params.delete(:distribute)
    if distribute && params[:direction] == :horizontal
      width_found = to_px(:width)
      params[:spacing] = "#{found_spacing_in_percent(width_found, params[:width], blocks.length)}%"
    elsif distribute
      height_found = to_px(:height)
      params[:spacing] = found_spacing_in_percent(height_found, params[:height], blocks.length)
    end
    blocks.each do |bloc_id, block_to_create|
      sanitized_bloc_data = params.merge(block_to_create)
      block({ data: sanitized_bloc_data }.merge({ id: bloc_id }).merge(params))
    end
  end

  def sub_block(sub_params, spacing_found = 3)
    num_blocks = sub_params.size
    parent_width = to_px(:width)
    total_ratios = sub_params.values.sum { |sub_content| sub_content[:width] }
    total_spacing = (num_blocks + 1) * spacing_found
    available_width = parent_width - total_spacing
    left_offset = spacing_found
    sub_params.each do |sub_id, sub_content|
      ratio = sub_content[:width]
      block_width = (available_width * ratio) / total_ratios
      sub_created = box({ id: sub_id, height: '100%', left: left_offset, role: :sub })
      sub_content["width"] = block_width
      sub_created.set(sub_content)
      sub_created.width(block_width)
      left_offset += block_width + spacing_found
      sub_created.width(sub_created.to_percent(:width))
      sub_created.left(sub_created.to_percent(:left))
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

  def collapse(new_atome)
    initialized_procs = []
    initialized = Atome.initialized
    new_atome.each do |element, value|
      send(element, value)
      initialized_proc = initialized[element]
      initialized_procs << { value => initialized_proc } if initialized_proc.is_a?(Proc)
    end

    initialized_procs.each do |value|
      value.each do |val, proc|
        instance_exec(val, &proc)
      end
    end

  end

  def add_text_visual(params)
    html.add_font_to_css(params)
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
    # Attention: the method is the same as the one used for the particle
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

  # def store(params)
  #   params.each do |particle_to_save, data|
  #     # @!atome[particle_to_save]=data
  #     # instance_variable_set(particle_to_save,data)
  #   end
  #
  # end

  # def history(filter = {})
  #
  #   filter[:id] = @id
  #   Universe.story(filter)
  # end

  def history
    Universe.story
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
  # # write what you want …
  # end
  # def particle_callback(element=nil)
  #   if element
  #     Atome.define_method("#{element}_callback") do |return_params|
  #       # we test if instance_variable_get("@#{element}_code") is a hash for the can se the particle value is a hash
  #       proc_found = if instance_variable_get("@#{element}_code").instance_of? Hash
  #                      # Then we get the first item of the hash because the proc is fasten to it
  #                      instance_variable_get("@#{element}_code").values.first
  #                      # instance_exec(@callback[element], proc_found)if proc_found.is_a? Proc
  #                    else
  #                      instance_variable_get("@#{element}_code")[element]
  #                      # instance_exec(@callback[element], proc_found)if proc_found.is_a? Proc
  #                    end
  #       # array_of_proc_found.each do |proc_found|
  #       proc_found.call(return_params) if proc_found.is_a? Proc
  #       # end if array_of_proc_found
  #
  #       # if array_of_proc_found
  #       #   proc_found= array_of_proc_found.shift
  #       #   proc_found.call(return_params) if proc_found.is_a? Proc
  #       # end
  #
  #     end
  #   end
  #
  # end

  def particle_callback(element = nil)
    if element
      Atome.define_method("#{element}_callback") do |return_params = nil|
        if return_params
          proc_found = if instance_variable_get("@#{element}_code").instance_of? Hash
                         instance_variable_get("@#{element}_code").values.first
                       else
                         instance_variable_get("@#{element}_code")[element]
                       end
          proc_found.call(return_params) if proc_found.is_a? Proc
        else
          puts "Warning: #{element}_callback called without return_params"
        end
      end
    else
      puts "Warning: particle_callback called without element"
    end
  end

  def store_ruby_callback(params)

    params.each do |element, value_v|
      send("#{element}_code")[element].call(value_v)
    end
  end

  def read_ruby_callback(element)
    # methode used by tauri when there's acallback
    send("#{element}_callback")
  end

  # this method generate the method accessible for end developers
  # it's the send the method define in "particle_callback"
  def callback(element, return_params = nil)
    send("#{element}_callback", return_params)
  end

  def js_callback(id, particle, value, sub = nil)
    current_atome = grab(id)
    proc_found = current_atome.instance_variable_get("@#{particle}_code")[particle.to_sym]
    instance_exec(value, &proc_found) if proc_found.is_a?(Proc)
  end

  # def callback(data)
  #   @callback[data.keys[0]] = data[data.keys[0]]
  # end
  def delete_with_callback(&callback)
    check_interval = 0.05 # Intervalle de vérification en secondes

    check_completion = proc do
      # Vérifie si les opérations de rendu sont terminées (tu peux affiner la condition si nécessaire)
      operations_completed = true # Supposition : opération immédiate pour l'instant

      if operations_completed
        # Supprimer l’atome de l’univers
        Universe.delete(@aid)
        # callback.call if callback # Appeler le callback s’il est défini
      else
        # Relancer la vérification après un délai
        wait(check_interval) { check_completion.call }
      end
    end

    # Démarrer la vérification
    check_completion.call
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

  def particles_to_hash
    hash = {}
    instance_variables.each do |var|
      next if %i[@selection_style @html_object @history @initialized @tick @controller_proc].include?(var)
      hash[var.to_s.delete('@').to_sym] = instance_variable_get(var)
    end
    hash
  end

  # def refresh
  #
  #   # we get the current color because they will be removed
  #   particles_found = particles_to_hash.dup
  #   # id_found=id
  #   data_found=particles_found.delete(:data)
  #   attach_found=particles_found.delete(:attach)
  #   apply_found=particles_found.delete(:apply)
  #   particles_found.each do |particle_found, value_found|
  #     send(particle_found, value_found)
  #   end
  #   # Universe.applicable_atomes.each do |atome_type|
  #   #
  #   #   send(atome_type).each do |col|
  #   #     apply(col)
  #   #   end
  #   # end
  #   # grab(attach_found).fasten(id_found)
  #   data(data_found)
  #
  #   apply_found.delete(:text_color) #TODO : patch here :  the array is not correctly ordered so default color are apply over the next
  #   apply_found.delete(:box_color) ##TODO : patch here :  the array is not correctly ordered so default color are apply over the next
  #   apply(apply_found)
  #   # attach(attach_found)
  # end

  def refresh_atome
    id_found = id.dup
    id(:temporary)
    fasten_atomes = []
    fasten_found = fasten.dup
    fasten_found.each do |child_id_found|
      child_found = grab(child_id_found)
      if child_found
        new_child = child_found.duplicate({})
        fasten_atomes << new_child.id
      end
    end

    infos_found = infos.dup
    data_found = infos_found.delete(:data)
    keys_to_delete = %i[history callback duplicate copy paste touch_code html fasten aid]
    keys_to_delete.each { |key| infos_found.delete(key) }
    new_atome_id = id_found
    infos_found[:id] = new_atome_id
    new_atome = Atome.new(infos_found)
    @duplicate ||= {}
    @duplicate[new_atome_id] = new_atome
    new_atome.data(data_found) # needed because if atome type is a text we need add type at the end
    new_atome
  end

  def refresh(&bloc)
    retrieve({ self: true }) do |child|
      child.refresh_atome
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

  # def detach_atome(atome_id_to_detach)
  #   atome_to_detach = grab(atome_id_to_detach)
  #   # TODO: remove the condition below and find why it try to detach an atome that doesn't exist
  #   nil unless atome_to_detach
  # end

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
    #  we delete the parent (the layout) if it no more children fasten
    parent_found.delete(true) if parent_found.fasten.length == 0
  end

  def server(server_params = nil)
    if server_params
      @current_server = server_params
    else
      @current_server
    end
  end

  def init_websocket
    connection(@current_server)
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

  def get_localstorage_content
    storage = JS.global[:localStorage]
    storage_array = storage.to_a
    storage_items = {}
    storage_array.each_with_index do |_i, index|
      key = JS.global[:localStorage].key(index)
      value = JS.global[:localStorage].getItem(key)
      storage_items[key] = value
    end
    storage_items
  end

  # def to_sym
  #   puts "sanitizer temp patch when an atome is passed instead of an id"
  #   @id
  # end
  # def transform_to_string_keys_and_values(hash)
  #   hash.transform_keys(&:to_s).transform_values do |value|
  #     if value.is_a?(Hash)
  #       transform_to_string_keys_and_values(value)
  #     else
  #       value.to_s
  #     end
  #   end
  # end

  def sync(params, &bloc)
    params = { data: params } unless params.instance_of? Hash
    message_id = "msg_#{Universe.messages.length}"
    params[:message_id] = message_id
    Universe.store_messages({ msg_nb: message_id, proc: bloc })
    # params = transform_to_string_keys_and_values(params)
    html.send_message(params)
  end

  def alternate(*states)
    @alternate ||= { state: 0 }
    @alternate[:data] = states
    if @alternate[:state] < states.length - 1
      @alternate[:state] += 1
    else
      @alternate[:state] = 0
    end

    current_state = @alternate[:data][@alternate[:state] - 1]
    if current_state.instance_of?(Hash)
      current_state.each do |state, value|
        send(state, value)
      end
    end
    current_state
  end

  def extract_attribute(attributes_string, attr_name)
    # find attribute with single  or double quotes
    if attributes_string =~ /\b#{attr_name}\s*=\s*["']([^"']*)["']/
      $1
    else
      nil
    end
  end




  def normalise_svg(svg_content)
    # Préserver le style original s'il existe
    style_match = svg_content.match(/style=["']([^"']*)["']/)
    original_style = style_match ? style_match[1] : ""

    # Extraire les dimensions originales
    viewbox_match = svg_content.match(/viewBox=["']([^"']*)["']/)
    width_match = svg_content.match(/width=["']([^"']*)["']/)
    height_match = svg_content.match(/height=["']([^"']*)["']/)

    # Valeurs par défaut
    min_x, min_y, width, height = 0, 0, 1024, 1024

    # Extraire viewBox si elle existe
    if viewbox_match
      dimensions = viewbox_match[1].split(/\s+/).map { |dim| dim.to_f }
      min_x, min_y, width, height = dimensions if dimensions.size == 4
      # Sinon, utiliser width et height si disponibles
    elsif width_match && height_match
      width_str = width_match[1].strip
      height_str = height_match[1].strip

      # Supprimer les unités comme "px", "em", etc.
      width = width_str.gsub(/[^0-9.]/, '').to_f
      height = height_str.gsub(/[^0-9.]/, '').to_f

      # Valeurs par défaut si invalides
      width = 1024 if width <= 0
      height = 1024 if height <= 0
    end

    # Calculer l'échelle pour maintenir les proportions
    scale_x = 1024.0 / width
    scale_y = 1024.0 / height
    scale = [scale_x, scale_y].min

    # Calculer le décalage pour centrer
    offset_x = (1024 - (width * scale)) / 2
    offset_y = (1024 - (height * scale)) / 2

    # Trouver la balise svg ouvrante
    svg_open_match = svg_content.match(/<svg[^>]*>/)
    return svg_content unless svg_open_match

    # Créer une nouvelle balise svg avec la viewBox normalisée
    # Préserver les attributs originaux importants
    original_svg_tag = svg_open_match[0]

    # Extraire les attributs à préserver
    xmlns = original_svg_tag.match(/xmlns=["'][^"']*["']/)
    xmlns = xmlns ? xmlns[0] : 'xmlns="http://www.w3.org/2000/svg"'

    version = original_svg_tag.match(/version=["'][^"']*["']/)
    version = version ? version[0] : ''

    # Reconstruire le style si nécessaire
    style_attr = original_style.empty? ? '' : " style=\"#{original_style}\""

    # Nouvelle balise SVG
    new_svg_open = "<svg#{style_attr} viewBox=\"0 0 1024 1024\" width=\"100%\" height=\"100%\" #{xmlns} #{version}>"

    # Extraire le contenu entre les balises svg
    opening_tag_end = svg_content.index(svg_open_match[0]) + svg_open_match[0].length
    closing_tag_start = svg_content.rindex('</svg>')

    if closing_tag_start && opening_tag_end < closing_tag_start
      svg_inner_content = svg_content[opening_tag_end...closing_tag_start]
    else
      return svg_content # Structure SVG invalide
    end

    # Nouvelle transformation à appliquer
    new_transform = "translate(#{offset_x}, #{offset_y}) scale(#{scale})"

    # Vérifier si un élément g existe déjà au premier niveau
    g_match = svg_inner_content.match(/^\s*<g([^>]*)>/)

    if g_match
      # Élément g trouvé, gérer l'attribut transform existant
      g_attributes = g_match[1]
      transform_match = g_attributes.match(/transform=["']([^"']*)["']/)

      if transform_match
        # Combiner la transformation existante avec la nouvelle
        existing_transform = transform_match[1]
        combined_transform = "#{existing_transform} #{new_transform}"

        # Remplacer l'attribut transform existant
        modified_g_tag = g_match[0].gsub(/transform=["'][^"']*["']/, "transform=\"#{combined_transform}\"")
        new_inner_content = svg_inner_content.sub(g_match[0], modified_g_tag)
      else
        # Ajouter l'attribut transform à la balise g existante
        modified_g_tag = g_match[0].sub(/<g/, "<g transform=\"#{new_transform}\"")
        new_inner_content = svg_inner_content.sub(g_match[0], modified_g_tag)
      end
    else
      # Pas d'élément g au premier niveau, en créer un nouveau
      new_inner_content = "<g transform=\"#{new_transform}\">#{svg_inner_content}</g>"
    end

    # Assembler le SVG final
    "#{new_svg_open}#{new_inner_content}</svg>"
  end



  def convert_svg(svg_content)
    @svg = svg_content
    # Suppression des commentaires
    svg_content = svg_content.gsub(/<!--.*?-->/m, '')
    atome_content = []

    svg_content.scan(/<circle\b([^>]*)>/) do |attributes_array|
      attributes = attributes_array[0]
      # id = extract_attribute(attributes, 'id')
      stroke = extract_attribute(attributes, 'stroke') || 'none'
      stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
      fill = extract_attribute(attributes, 'fill') || 'none'
      cx = extract_attribute(attributes, 'cx')
      cy = extract_attribute(attributes, 'cy')
      r = extract_attribute(attributes, 'r')

      if cx && cy && r
        circle_def = {
          circle: {
            cx: cx,
            cy: cy,
            r: r,
            id: identity_generator,
            stroke: stroke,
            "stroke-width" => stroke_width,
            fill: fill
          }
        }
        atome_content << circle_def
      end
    end

    svg_content.scan(/<path\b([^>]*)>/) do |attributes_array|
      attributes = attributes_array[0]
      # id = extract_attribute(attributes, 'id')
      stroke = extract_attribute(attributes, 'stroke') || 'none'
      stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
      fill = extract_attribute(attributes, 'fill') || 'none'
      d = extract_attribute(attributes, 'd')

      if d
        path_def = {
          path: {
            d: d,
            id: identity_generator,
            stroke: stroke,
            'stroke-width' => stroke_width,
            fill: fill
          }
        }
        atome_content << path_def
      end
    end

    svg_content.scan(/<rect\b([^>]*)>/) do |attributes_array|
      attributes = attributes_array[0]
      # id = extract_attribute(attributes, 'id')
      stroke = extract_attribute(attributes, 'stroke') || 'none'
      stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
      fill = extract_attribute(attributes, 'fill') || 'none'
      x = extract_attribute(attributes, 'x')
      y = extract_attribute(attributes, 'y')
      width = extract_attribute(attributes, 'width')
      height = extract_attribute(attributes, 'height')

      if x && y && width && height
        rect_def = {
          rect: {
            x: x,
            y: y,
            width: width,
            height: height,
            id: identity_generator,
            stroke: stroke,
            'stroke-width' => stroke_width,
            fill: fill
          }
        }
        atome_content << rect_def
      end
    end

    svg_content.scan(/<line\b([^>]*)>/) do |attributes_array|
      attributes = attributes_array[0]
      # id = extract_attribute(attributes, 'id')
      stroke = extract_attribute(attributes, 'stroke') || 'none'
      stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
      x1 = extract_attribute(attributes, 'x1')
      y1 = extract_attribute(attributes, 'y1')
      x2 = extract_attribute(attributes, 'x2')
      y2 = extract_attribute(attributes, 'y2')

      if x1 && y1 && x2 && y2
        line_def = {
          line: {
            x1: x1,
            y1: y1,
            x2: x2,
            y2: y2,
            id: identity_generator,
            stroke: stroke,
            'stroke-width' => stroke_width
          }
        }
        atome_content << line_def
      end
    end

    svg_content.scan(/<ellipse\b([^>]*)>/) do |attributes_array|
      attributes = attributes_array[0]
      # id = extract_attribute(attributes, 'id')
      stroke = extract_attribute(attributes, 'stroke') || 'none'
      stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
      fill = extract_attribute(attributes, 'fill') || 'none'
      cx = extract_attribute(attributes, 'cx')
      cy = extract_attribute(attributes, 'cy')
      rx = extract_attribute(attributes, 'rx')
      ry = extract_attribute(attributes, 'ry')

      if cx && cy && rx && ry
        ellipse_def = {
          ellipse: {
            cx: cx,
            cy: cy,
            rx: rx,
            ry: ry,
            id: identity_generator,
            stroke: stroke,
            'stroke-width' => stroke_width,
            fill: fill
          }
        }
        atome_content << ellipse_def
      end
    end

    svg_content.scan(/<polygon\b([^>]*)>/) do |attributes_array|
      attributes = attributes_array[0]
      # id = extract_attribute(attributes, 'id')
      stroke = extract_attribute(attributes, 'stroke') || 'none'
      stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
      fill = extract_attribute(attributes, 'fill') || 'none'
      points = extract_attribute(attributes, 'points')

      if points
        polygon_def = {
          polygon: {
            points: points,
            id: identity_generator,
            stroke: stroke,
            'stroke-width' => stroke_width,
            fill: fill
          }
        }
        atome_content << polygon_def
      end
    end

    svg_content.scan(/<polyline\b([^>]*)>/) do |attributes_array|
      attributes = attributes_array[0]
      # id = extract_attribute(attributes, 'id')
      stroke = extract_attribute(attributes, 'stroke') || 'none'
      stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
      fill = extract_attribute(attributes, 'fill') || 'none'
      points = extract_attribute(attributes, 'points')

      if points
        polyline_def = {
          polyline: {
            points: points,
            id: identity_generator,
            stroke: stroke,
            'stroke-width' => stroke_width,
            fill: fill
          }
        }
        atome_content << polygon_def
      end
    end

    atome_content
  end

  # def convert_svg(svg_content)
  #   @svg = svg_content
  #   atome_content = []
  #
  #
  #   svg_content.scan(/<circle\b([^>]*)>/) do |attributes_array|
  #     attributes = attributes_array[0]
  #     id = extract_attribute(attributes, 'id')
  #     stroke = extract_attribute(attributes, 'stroke') || 'none'
  #     stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
  #     fill = extract_attribute(attributes, 'fill') || 'none'
  #     cx = extract_attribute(attributes, 'cx')
  #     cy = extract_attribute(attributes, 'cy')
  #     r = extract_attribute(attributes, 'r')
  #
  #     if cx && cy && r
  #       circle_def = {
  #         circle: {
  #           cx: cx,
  #           cy: cy,
  #           r: r,
  #           id: id || 'circle_id',
  #           stroke: stroke,
  #           "stroke-width" => stroke_width,
  #           fill: fill
  #         }
  #       }
  #       atome_content << circle_def
  #     end
  #   end
  #
  #   svg_content.scan(/<path\b([^>]*)>/) do |attributes_array|
  #     attributes = attributes_array[0]
  #     id = extract_attribute(attributes, 'id')
  #     stroke = extract_attribute(attributes, 'stroke') || 'none'
  #     stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
  #     fill = extract_attribute(attributes, 'fill') || 'none'
  #     d = extract_attribute(attributes, 'd')
  #
  #     if d
  #       path_def = {
  #         path: {
  #           d: d,
  #           id: id || 'path_id',
  #           stroke: stroke,
  #           'stroke-width' => stroke_width,
  #           fill: fill
  #         }
  #       }
  #       atome_content << path_def
  #     end
  #   end
  #
  #   svg_content.scan(/<rect\b([^>]*)>/) do |attributes_array|
  #     attributes = attributes_array[0]
  #     id = extract_attribute(attributes, 'id')
  #     stroke = extract_attribute(attributes, 'stroke') || 'none'
  #     stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
  #     fill = extract_attribute(attributes, 'fill') || 'none'
  #     x = extract_attribute(attributes, 'x')
  #     y = extract_attribute(attributes, 'y')
  #     width = extract_attribute(attributes, 'width')
  #     height = extract_attribute(attributes, 'height')
  #
  #     if x && y && width && height
  #       rect_def = {
  #         rect: {
  #           x: x,
  #           y: y,
  #           width: width,
  #           height: height,
  #           id: id || 'rect_id',
  #           stroke: stroke,
  #           'stroke-width' => stroke_width,
  #           fill: fill
  #         }
  #       }
  #       atome_content << rect_def
  #     end
  #   end
  #
  #   svg_content.scan(/<line\b([^>]*)>/) do |attributes_array|
  #     attributes = attributes_array[0]
  #     id = extract_attribute(attributes, 'id')
  #     stroke = extract_attribute(attributes, 'stroke') || 'none'
  #     stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
  #     x1 = extract_attribute(attributes, 'x1')
  #     y1 = extract_attribute(attributes, 'y1')
  #     x2 = extract_attribute(attributes, 'x2')
  #     y2 = extract_attribute(attributes, 'y2')
  #
  #     if x1 && y1 && x2 && y2
  #       line_def = {
  #         line: {
  #           x1: x1,
  #           y1: y1,
  #           x2: x2,
  #           y2: y2,
  #           id: id || 'line_id',
  #           stroke: stroke,
  #           'stroke-width' => stroke_width
  #         }
  #       }
  #       atome_content << line_def
  #     end
  #   end
  #
  #   svg_content.scan(/<ellipse\b([^>]*)>/) do |attributes_array|
  #     attributes = attributes_array[0]
  #     id = extract_attribute(attributes, 'id')
  #     stroke = extract_attribute(attributes, 'stroke') || 'none'
  #     stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
  #     fill = extract_attribute(attributes, 'fill') || 'none'
  #     cx = extract_attribute(attributes, 'cx')
  #     cy = extract_attribute(attributes, 'cy')
  #     rx = extract_attribute(attributes, 'rx')
  #     ry = extract_attribute(attributes, 'ry')
  #
  #     if cx && cy && rx && ry
  #       ellipse_def = {
  #         ellipse: {
  #           cx: cx,
  #           cy: cy,
  #           rx: rx,
  #           ry: ry,
  #           id: id || 'ellipse_id',
  #           stroke: stroke,
  #           'stroke-width' => stroke_width,
  #           fill: fill
  #         }
  #       }
  #       atome_content << ellipse_def
  #     end
  #   end
  #
  #   svg_content.scan(/<polygon\b([^>]*)>/) do |attributes_array|
  #     attributes = attributes_array[0]
  #     id = extract_attribute(attributes, 'id')
  #     stroke = extract_attribute(attributes, 'stroke') || 'none'
  #     stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
  #     fill = extract_attribute(attributes, 'fill') || 'none'
  #     points = extract_attribute(attributes, 'points')
  #
  #     if points
  #       polygon_def = {
  #         polygon: {
  #           points: points,
  #           id: id || 'polygon_id',
  #           stroke: stroke,
  #           'stroke-width' => stroke_width,
  #           fill: fill
  #         }
  #       }
  #       atome_content << polygon_def
  #     end
  #   end
  #
  #   svg_content.scan(/<polyline\b([^>]*)>/) do |attributes_array|
  #     attributes = attributes_array[0]
  #     id = extract_attribute(attributes, 'id')
  #     stroke = extract_attribute(attributes, 'stroke') || 'none'
  #     stroke_width = extract_attribute(attributes, 'stroke-width') || '0'
  #     fill = extract_attribute(attributes, 'fill') || 'none'
  #     points = extract_attribute(attributes, 'points')
  #
  #     if points
  #       polyline_def = {
  #         polyline: {
  #           points: points,
  #           id: id || 'polyline_id',
  #           stroke: stroke,
  #           'stroke-width' => stroke_width,
  #           fill: fill
  #         }
  #       }
  #       atome_content << polyline_def
  #     end
  #   end
  #
  #   atome_content
  # end

  def vectoriser(svg_content)
    convert_svg(svg_content)
  end

  def svg
    @svg
  end

  def b64_to_tag(params)
    unless params[:target]
      new_img = image({ left: 0, top: 0 })
      params[:target] = new_img.id
    end
    new_tag = <<STRR
  var serializer = new XMLSerializer();
  var svg_string = serializer.serializeToString(document.getElementById('#{params[:id]}'));
  var encoded_svg = btoa(unescape(encodeURIComponent(svg_string)));
  var img = document.getElementById('#{params[:target]}');
  img.src = "data:image/svg+xml;base64," + encoded_svg;
  var parent = document.getElementById('#{id}');
  parent.appendChild(img);
STRR
    JS.eval(new_tag)
    new_atome = grab(params[:target])
    html_obj = new_atome.html.object
    obj_src = html_obj[:src]
    new_atome.path(obj_src)
    new_atome
  end

  def svg_to_vector(params, &proc)
    @svg_to_vector = proc
    source = params[:source]
    img_element = JS.global[:document].getElementById(source.to_s)
    svg_path = img_element.getAttribute("src")
    target = params[:target]
    unless params[:normalize]
      params[:normalize]= false
    end
    normalise= params[:normalize]

    JS.eval("replaceSVGContent('#{svg_path}', '#{target}', '#{id}', '#{normalise}')")
  end

  def determine_action(file_content)

    default_action = { open: true, execute: false }
    action = default_action.dup

    if file_content.lines.first =~ /#\s*\{BROWSER:\s*\{(.*?)\}\}/
      content = $1.split(',').map { |pair| pair.split(':').map(&:strip) }.to_h
      content.each do |key, value|
        action[key.to_sym] = value == 'true'
      end
    end
    action
  end

  def extract_and_sanitize_js(code)
    sanitized_code = ""
    inside_js_block = false
    block_delimiter = ""

    code.each_line do |line|
      if line =~ /(\w+)\s*=\s*<<~(\w+)/
        inside_js_block = true
        block_delimiter = $2
        sanitized_code += "#{$1} = %Q{"
        next
      end

      if inside_js_block
        if line.strip == block_delimiter
          inside_js_block = false
          sanitized_code += "}\n"
        else
          clean_line = line
                         .gsub('\\', '\\\\')
                         .gsub('{', '\\{')
                         .gsub('}', '\\}')
                         .gsub('"', '\\"')
          sanitized_code += clean_line
        end
      else
        sanitized_code += line
      end
    end

    sanitized_code
  end

  def browser(base_path)
    @path != ''
    unless grab(:file_browser)
      @filer = grab(:intuition).box({ id: :file_browser,
                                      tag: { system: true },
                                      drag: true,
                                      top: 9,
                                      depth: 1,
                                      left: 600,
                                      # right:90,
                                      width: 120,
                                      height: 600,
                                      smooth: 8,
                                      overflow: :auto,
                                      apply: %i[inactive_tool_col tool_box_border tool_shade],
                                    })
    end

    offset = 0
    @path = base_path

    @filer.text({
                  data: 'parent',
                  color: :white,
                  cursor: :pointer,
                  left: 20,
                  top: 0,
                  position: :absolute,
                }).touch(:tap) do

      @filer.clear(true)
      @path = @path.chomp("/")
      @path = @path[0, @path.rindex("/")] + "/"
      browser(@path)
    end

    # folder creation
    A.terminal("cd #{base_path}  && ls -d */ 2>/dev/null") do |data|
      data.each_line do |file|
        file = file.strip
        next if file.empty?

        parts = file.split("/")

        parts.each_with_index do |part, index|
          next if part.empty?
          @filer.text({
                        data: part,
                        color: :white,
                        cursor: :pointer,
                        left: index * 20,
                        top: 33 + offset,
                        position: :absolute,
                      }).touch(:tap) do

            @filer.clear(true)
            new_path = @path + "/#{part}"
            browser(new_path)
          end

          offset += 20
        end
      end
    end
    # files creation
    v = grab(:view)
    v.terminal("cd #{base_path}  && ls -p | grep -v /") do |data|
      data.each_line do |file|
        file = file.strip
        next if file.empty?

        parts = file.split("/")

        parts.each_with_index do |part, index|
          next if part.empty?
          file_path = "#{base_path}/#{file}"
          # FIXME check in the code why we need to do that
          file_path = file_path.gsub("//", "/")
          @filer.text({
                        data: part,
                        color: :orange,
                        cursor: :pointer,
                        left: index * 20,
                        top: 33 + offset,
                        position: :absolute
                      }).touch(:tap) do
            # touch here

            A.read(file_path) do |file_data|

              actions = determine_action(file_data)
              if actions[:open] == true

                editor = grab(:intuition).box({
                                                left: 150,
                                                depth: 0,
                                                top: 9,
                                                width: 399,
                                                height: 699,
                                                color: { red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0 },
                                                overflow: :auto,
                                                drag: true,
                                                resize: true,
                                              })

                # file title :
                editor.text({ data: @path + '/' + file, top: 0, left: 6, color: :orange })
                # file close
                close = editor.circle({ color: :yellowgreen, left: :auto, right: 6, top: 9, width: 15, height: 15 })
                close.text({ data: :x, top: 0, left: 3, color: :black, position: :absolute })
                close.touch(:tap) do
                  editor.delete(true)
                end
                # file save
                save = editor.circle({ color: :orange, left: :auto, right: 33, top: 9, width: 15, height: 15 })
                save.touch(:tap) do
                  alert :save_file
                end
                # file body :
                body = editor.text({ top: 39, left: 6, color: :lightgrey, data: file_data, edit: true })
              end

              # file exec if .rb :
              if file.end_with?('.rb')
                exec = editor.circle({ color: :red, left: :auto, right: 66, top: 9, width: 15, height: 15 })
                exec.touch(:tap) do
                  grab(:view).clear(true)
                  code = body.data
                  sanitized_code = extract_and_sanitize_js(code)
                  grab(:view).instance_eval(sanitized_code)
                end
              end

              if actions[:execute] == true
                grab(:view).clear(true)
                sanitized_code = extract_and_sanitize_js(file_data)
                grab(:view).instance_eval(sanitized_code)
              end
              #
            end
          end

          offset += 20
        end
      end
    end
  end

  # allow to simulate or automate click , tap , etccc
  def simulate(type)
    current_obj = grab(self.id)
    codes_found = current_obj.instance_variable_get("@#{type}_code")
    codes_found.each do |event, content|
      if content.instance_of?(Array)
        content.each do |code|
          instance_exec(current_obj, event, code, &code)
        end
      end
    end if codes_found.instance_of?(Hash)
  end
end



