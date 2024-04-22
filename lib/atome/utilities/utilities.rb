# frozen_string_literal: true

# toolbox   method here
require 'json'

class Atome
  class << self
    attr_accessor :initialized

    def sanitize_data_for_json(data)
      data = data.gsub('"', '\\"')
      # case data
      # when String
      #   data.gsub('"', '\\"')
      # when Hash
      #   data.transform_values { |value| sanitize_data(value) }
      # when Array
      #   data.map { |value| sanitize_data(value) }
      # else
      #   data
      # end
      data
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

    # atome builder
    def preset_builder(preset_name, &bloc)
      # Important : previously def box , def circle
      Universe.atome_preset << preset_name
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
            instance_exec({ original: value_before, altered: args, particle: monitored_particle }, &bloc) if bloc.is_a?(Proc)
            original_method.call(*args)
          end
        end
      end
    end

    def controller_listener
      return if $host == :html
      atome_js.JS.controller_listener() # js folder atome/helipers/atome/communication
    end

    def handleSVGContent(svg_content, target)
      puts svg_content
      atome_content = A.vectorizer(svg_content)
      target_vector = grab(target)
      target_vector.data(atome_content)
    end

  end

  @initialized = {}

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

  def js_callback(id, particle, value,sub=nil )
    current_atome= grab(id)
   #  # alert current_atome.instance_variable_get('@record_code')
    proc_found= current_atome.instance_variable_get("@#{particle}_code")[particle.to_sym]
    # proc_found= current_atome.instance_variable_get("@record_code")[:record]
   #  # alert particle.class
   #  # alert proc_found.class
    # proc_found.call
   instance_exec(value, &proc_found) if proc_found.is_a?(Proc)
   # #  # puts "params to be exec #{id}, #{particle}, #{value}, #{sub}"
   #  alpha= grab(:the_big_box)
   #  proc_found= alpha.instance_variable_get("@record_code")[:record]
    # proc_found.call

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

  def particles_to_hash
    hash = {}
    instance_variables.each do |var|
      next if %i[@html_object @history, @initialized].include?(var)

      hash[var.to_s.delete('@').to_sym] = instance_variable_get(var)
    end
    hash
  end

  def refresh
    # we get the current color because they will be removed
    particles_found = particles_to_hash
    particles_found.each do |particle_found, value_found|
      send(particle_found, value_found)
    end
    color.each do |col|
      apply(col)
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

  def sync(params, &bloc)
    params = { data: params } unless params.instance_of? Hash
    message_id = "msg_#{Universe.messages.length}"
    params[:message_id] = message_id
    Universe.store_messages({ msg_nb: message_id, proc: bloc })
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

  def vectorizer(svg_content)
    atome_content = []

    # circle_regex = /<circle\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)"\s+cx\s*=\s*"(\d+)"\s+cy\s*=\s*"(\d+)"\s+r\s*=\s*"(\d+)".*?\/>/
    circle_regex = /<circle\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)"\s+cx\s*=\s*"(\d+(?:\.\d+)?)"\s+cy\s*=\s*"(\d+(?:\.\d+)?)"\s+r\s*=\s*"(\d+(?:\.\d+)?)"\s*.*?\/>/

    svg_content.scan(circle_regex) do |id, stroke, stroke_width, fill, cx, cy, r|
      stroke = stroke || 'none'
      stroke_width = stroke_width || '0'
      fill = fill || 'none'
      circle_def = { circle: { cx: cx, cy: cy, r: r, id: id, stroke: stroke, "stroke-width" => stroke_width, fill: fill } }
      atome_content << circle_def
    end

    # path_regex = /<path\s+.*?d\s*=\s*"([^"]+)"\s+(?:id\s*=\s*"(.*?)"\s+)?(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)".*?\/>/
    path_regex = /<path\s+.*?d\s*=\s*"([^"]+)"\s+(?:id\s*=\s*"(.*?)"\s+)?(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)".*?\/>/

    svg_content.scan(path_regex) do |d, id, stroke, stroke_width, fill|
      id = id || 'path_id'
      stroke = stroke || 'none'
      stroke_width = stroke_width || '0'
      fill = fill || 'none'
      path_def = { path: { d: d, id: id, stroke: stroke, 'stroke-width' => stroke_width, fill: fill } }
      atome_content << path_def
    end

    # rect_regex = /<rect\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)"\s+x\s*=\s*"(\d+)"\s+y\s*=\s*"(\d+)"\s+width\s*=\s*"(\d+)"\s+height\s*=\s*"(\d+)".*?\/>/
    rect_regex = /<rect\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)"\s+x\s*=\s*"(\d+(?:\.\d+)?)"\s+y\s*=\s*"(\d+(?:\.\d+)?)"\s+width\s*=\s*"(\d+(?:\.\d+)?)"\s+height\s*=\s*"(\d+(?:\.\d+)?)"\s*.*?\/>/

    svg_content.scan(rect_regex) do |id, stroke, stroke_width, fill, x, y, width, height|
      id = id || 'rect_id'
      stroke = stroke || 'none'
      stroke_width = stroke_width || '0'
      fill = fill || 'none'
      rect_def = { rect: { x: x, y: y, width: width, height: height, id: id, stroke: stroke, 'stroke-width' => stroke_width, fill: fill } }
      atome_content << rect_def
    end

    # line_regex = /<line\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?x1\s*=\s*"(\d+)"\s+y1\s*=\s*"(\d+)"\s+x2\s*=\s*"(\d+)"\s+y2\s*=\s*"(\d+)".*?\/>/
    line_regex = /<line\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?x1\s*=\s*"(\d+(?:\.\d+)?)"\s+y1\s*=\s*"(\d+(?:\.\d+)?)"\s+x2\s*=\s*"(\d+(?:\.\d+)?)"\s+y2\s*=\s*"(\d+(?:\.\d+)?)"\s*.*?\/>/

    svg_content.scan(line_regex) do |id, stroke, stroke_width, x1, y1, x2, y2|
      id = id || 'line_id'
      stroke = stroke || 'none'
      stroke_width = stroke_width || '0'
      line_def = { line: { x1: x1, y1: y1, x2: x2, y2: y2, id: id, stroke: stroke, 'stroke-width' => stroke_width } }
      atome_content << line_def
    end

    # ellipse_regex = /<ellipse\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)"\s+cx\s*=\s*"(\d+)"\s+cy\s*=\s*"(\d+)"\s+rx\s*=\s*"(\d+)"\s+ry\s*=\s*"(\d+)".*?\/>/
    ellipse_regex = /<ellipse\s+.*?id\s*=\s*"(.*?)"\s+(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?fill\s*=\s*"(.*?)"\s+cx\s*=\s*"(\d+(?:\.\d+)?)"\s+cy\s*=\s*"(\d+(?:\.\d+)?)"\s+rx\s*=\s*"(\d+(?:\.\d+)?)"\s+ry\s*=\s*"(\d+(?:\.\d+)?)"\s*.*?\/>/

    svg_content.scan(ellipse_regex) do |id, stroke, stroke_width, fill, cx, cy, rx, ry|
      id = id || 'ellipse_id'
      stroke = stroke || 'none'
      stroke_width = stroke_width || '0'
      fill = fill || 'none'
      ellipse_def = { ellipse: { cx: cx, cy: cy, rx: rx, ry: ry, id: id, stroke: stroke, 'stroke-width' => stroke_width, fill: fill } }
      atome_content << ellipse_def
    end

    # polygon_regex = /<polygon\s+(?:id\s*=\s*"(.*?)"\s+)?(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?(?:fill\s*=\s*"(.*?)"\s+)?points\s*=\s*"([^"]+)".*?\/>/
    polygon_regex = /<polygon\s+(?:id\s*=\s*"(.*?)"\s+)?(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?(?:fill\s*=\s*"(.*?)"\s+)?points\s*=\s*"([^"]+)".*?\/>/
    svg_content.scan(polygon_regex) do |id, stroke, stroke_width, fill, points|
      id ||= 'polygon_id'
      stroke ||= 'none'
      stroke_width ||= '0'
      fill ||= 'none'
      polygon_def = { polygon: { points: points, id: id, stroke: stroke, 'stroke-width' => stroke_width, fill: fill } }
      atome_content << polygon_def
    end

    polyline_regex = /<polyline\s+.*?points\s*=\s*"([^"]+)"\s+(?:id\s*=\s*"(.*?)"\s+)?(?:stroke\s*=\s*"(.*?)"\s+)?(?:stroke-width\s*=\s*"(.*?)"\s+)?(?:fill\s*=\s*"(.*?)")?.*?\/>/
    svg_content.scan(polyline_regex) do |points, id, stroke, stroke_width, fill|
      id ||= 'polyline_id'
      stroke ||= 'none'
      stroke_width ||= '0'
      fill ||= 'none'
      polyline_def = { polyline: { points: points, id: id, stroke: stroke, 'stroke-width' => stroke_width, fill: fill } }
      atome_content << polyline_def
    end

    atome_content
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

  def fetch_svg(params)
    source = params[:source]
    img_element = JS.global[:document].getElementById(source.to_s)
    svg_path = img_element.getAttribute("src")
    target = params[:target]
    JS.eval("fetchSVGContent('#{svg_path}', '#{target}')")
  end

end



