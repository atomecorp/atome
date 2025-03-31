# frozen_string_literal: true

require 'time'

module ObjectExtension

  def new(params, &bloc)
    # Genesis = Genesis.Genesis
    if params.key?(:atome)
      Universe.add_atomes_specificities params[:atome]
      Genesis.build_atome(params[:atome], &bloc)
      # end
    elsif params.key?(:particle)
      if Universe.particle_list[params[:particle]]
        puts "particle #{params[:particle]} already exist you can't create it"
      else
        Atome.instance_variable_set("@main_#{params[:particle]}", bloc)
        # render indicate if the particle needs to be rendered
        # store tell the system if it need to store the particle value
        # type help the system what type of type the particle will receive and store
        Genesis.build_particle(params[:particle], { render: params[:render], return: params[:return],
                                                    store: params[:store], type: params[:type],
                                                    category: params[:category] }, &bloc)
      end
    elsif params.key?(:sanitizer)
      Genesis.build_sanitizer(params[:sanitizer], &bloc)
    elsif params.key?(:pre)
      Atome.instance_variable_set("@pre_#{params[:pre]}", bloc)
    elsif params.key?(:post)
      Atome.instance_variable_set("@post_#{params[:post]}", bloc)
    elsif params.key?(:after)
      Atome.instance_variable_set("@after_#{params[:after]}", bloc)
    elsif params.key?(:initialized)
      Atome.initialized[params[:initialized]] = bloc
    elsif params.key?(:read)
      Atome.instance_variable_set("@read_#{params[:read]}", bloc)
    elsif params[:renderer]
      renderer_found = params[:renderer]
      if params[:specific]
        Universe.set_atomes_specificities(params)
        params[:specific] = "#{params[:specific]}_"
      end
      render_method = "#{renderer_found}_#{params[:specific]}#{params[:method]}"
      Genesis.build_render(render_method, &bloc)
    elsif params.key?(:molecule)
      molecule = params[:molecule]
      Genesis.build_molecule(molecule, &bloc)
      Universe.add_to_molecule_list(molecule)
    elsif params.key?(:tool)
      # we only store tools definition in the universe so it can be instanced using "A.build_tool" method when needed
      tool_content = Atome.instance_exec(&bloc) if bloc.is_a?(Proc)
      Universe.tools[params[:tool]] = tool_content
      # Universe.tools[params[:tool]]=bloc
    elsif params.key?(:template)
      A.build_template(&bloc)
    elsif params.key?(:code)
      A.build_code(&bloc)
    elsif params.key?(:test)
      A.build_test(&bloc)
    elsif params.key?(:preset)
      Atome.preset_builder(params[:preset], &bloc)
    end
    super if defined?(super)
  end

end

# atome extensions
class Object
  include ObjectExtension

  def js_func(function_name, *params)
    args = params.map do |param|
      case param
      when String
        "'#{param}'"
      when TrueClass, FalseClass, Numeric
        param.to_s
      else
        raise ArgumentError, "Unsupported parameter type: #{param.class}"
      end
    end.join(", ")
    JS.eval("#{function_name}(#{args})")
  end

  def js_class(class_name)
    JS.eval("return new #{class_name}()")
  end

  def refresh
    grab(:view).retrieve do |child|
      child.refresh
    end
    # atomes_to_treat=grab(:view).fasten.dup
    # atomes_to_treat.each do |atome_found|
    #   grab(atome_found).refresh
    # end
  end

  def truncate_string(string, max_length)
    string.length > max_length ? string.slice(0, max_length) + '.' : string
  end

  def remove_key_pair_but(hash, keys_to_keep)
    hash.dup.delete_if do |key, value|
      key.is_a?(Integer) && key.even? && !keys_to_keep.include?(key)
    end.reject { |key, value| keys_to_keep.include?(key) }
  end

  def filter_keys_to_keep(hash, keys_to_keep)
    hash.select { |key, value| keys_to_keep.include?(key) }
  end

  def deep_copy(obj)
    # utility for buttons
    case obj
    when Hash
      obj.each_with_object({}) do |(k, v), h|
        h[deep_copy(k)] = deep_copy(v) unless k == :code # exception to avoid Proc accumulation
      end
    when Array
      obj.map { |e| deep_copy(e) }
    else
      obj.dup rescue obj
    end
  end

  def flash(msg)

    view_found= grab(:view)
    width_f=view_found.to_px(:width)
    height_f=view_found.to_px(:height)
    flash_box_width=235
    flash_box_height=112
    flash_box_left=width_f/2-flash_box_width/2
    flash_box_left_top=height_f/2-flash_box_height/2
    flash_box = box({left: flash_box_left, top:flash_box_left_top,  width: flash_box_width, height: flash_box_height, drag: true})

    flash_box.text({ data: msg, left: 6, top: 6, overflow: :auto })
    flash_box.touch(true) do
      # flash_box.delete({ recursive: true })
      flash_box.delete(true)
    end
  end

  def reorder_particles(hash_to_reorder)
    # we reorder the hash
    ordered_keys = %i[renderers id alien type attach int8 unit]

    ordered_part = ordered_keys.map { |k| [k, hash_to_reorder[k]] }.to_h
    other_part = hash_to_reorder.reject { |k, _| ordered_keys.include?(k) }
    # merge the parts  to obtain an re-ordered hash
    ordered_part.merge(other_part)
  end

  def delete (atomes)
    grab(:view).delete(atomes)
  end

  def identity_generator
    "a_#{Universe.app_identity}_#{Universe.counter}".to_sym
  end

  def hook(a_id)
    a_id = a_id.to_sym
    atome_get = ''
    Universe.atomes.each_value do |atome|
      atome_get = atome if atome.aid == a_id
    end
    atome_get
  end

  def grab(id_to_get)
    id_to_get = id_to_get.to_sym
    return if id_to_get == false
    aid_to_get = Universe.atomes_ids[id_to_get]
    aid_to_get = '' if aid_to_get.instance_of? Array
    Universe.atomes[aid_to_get]
  end

  # the method below generate Atome method creation at Object level
  def atome_method_for_object(element)

    Object.define_method element do |params = nil, &user_proc|
      default_parent = Essentials.default_params[element][:attach] || :view
      grab(default_parent).send(element, params, &user_proc)
    end
  end

  def wait(time, id = nil, &proc)
    # we generate an uniq id
    if [:kill, 'kill'].include?(time)
      JS.eval("clearTimeout(window.timeoutIds['#{id}']);")
    else
      obj = Object.new
      unique_id = obj.object_id

      id ||= unique_id
      time *= 1000
      callback_id = "myRubyCallback_#{id}"
      JS.global[callback_id.to_sym] = proc
      JS.eval("if (!window.timeoutIds) { window.timeoutIds = {}; } window.timeoutIds['#{id}'] = setTimeout(function() { #{callback_id}(); }, #{time});")
    end
    id
  end

  def repeat_callback(params, counter)
    @repeat[params].call(counter)
  end

  def repeat(delay = 1, repeat = 0, &proc)
    @repeat ||= []
    @repeat << proc
    repeat_id = @repeat.length - 1
    JS.eval(<<~JS)
                function repeat(action, interval, repetitions) {
               let count = 0;
               let intervalId = null;

               function executeAction() {
                   if (count < repetitions) {
                       action(count);
                       count++;
                   } else {
                       clearInterval(intervalId);
                   }
               }

               executeAction(); // execute immediatly
               intervalId = setInterval(executeAction, interval);
               return intervalId;
           }

           function myAction(counter) {
               atomeJsToRuby("repeat_callback(#{repeat_id}, "+counter+")")
           }

           const intervalId = repeat(myAction, #{delay} * 1000, #{repeat}); 

      return intervalId;
    JS
    repeat_id + 1
  end

  def stop(params)
    case params
    when Hash
      if params.key?(:repeat)
        repeater_to_stop = params[:repeat]
        JS.eval(<<~JS)
          clearInterval(#{repeater_to_stop});
        JS
      elsif params.key?(:wait)
        waiter_to_stop = params[:wait]
        JS.eval(<<~JS)
          clearTimeout(window.timeoutIds['#{waiter_to_stop}'])
        JS
      else
        puts "msg from stop method: the :repeat key doesn't exist"
      end
    else
      puts "msg from stop method, this params is not a Hash"
    end
  end

  def tagged(params)
    atome_get = []
    if params.instance_of? Hash
      params.each do |tag_name, tag_value|
        Universe.atomes.each do |atomes_id_found, atomes_found|
          if atomes_found.tag&.instance_of?(Hash) && (atomes_found.tag[tag_name] == tag_value)
            atome_get << atomes_id_found
          end
        end
      end
    else
      Universe.atomes.each do |atomes_id_found, atomes_found|
        atome_get << atomes_id_found if atomes_found.tag&.instance_of?(Hash) && atomes_found.tag[params]
      end
    end
    atome_get
  end

  # shortcut

  # we initialise $current_hovered_element
  $current_hovered_element = nil

  def shortcut(key:, option: nil, affect: :all, exclude: [], &block)
    element_ids = (Array(affect) + Array(exclude)).uniq

    element_ids.each do |element_id|
      element = JS.global[:document].querySelector("##{element_id}")
      unless element_id.to_sym == :all
        element.addEventListener("mouseenter") { $current_hovered_element = element_id }
        element.addEventListener("mouseleave") { $current_hovered_element = nil }
      end
    end

    JS.global[:document].addEventListener("keydown") do |native_event|
      event = Native(native_event)
      key_pressed = event[:key].to_s.downcase
      ctrl_pressed = event[:ctrlKey].to_s
      alt_pressed = event[:altKey].to_s
      meta_pressed = event[:metaKey].to_s

      modifier_matched = case option
                         when :ctrl then ctrl_pressed
                         when :alt then alt_pressed
                         when :meta then meta_pressed
                         else true
                         end

      affect_condition = affect == :all || Array(affect).include?($current_hovered_element)
      exclude_condition = !Array(exclude).include?($current_hovered_element)
      $current_hovered_element = :view if $current_hovered_element.nil?
      if key_pressed == key.to_s.downcase && modifier_matched && affect_condition && exclude_condition
        block.call(key_pressed, $current_hovered_element)
      end
    end
  end

  def console(debug)
    if debug
      console = box({ id: :console, width: :auto, height: 225, bottom: 0, top: :auto, left: 0, right: 0, depth: 30, color: { alpha: 0, red: 0, green: 0, blue: 0 } })
      console_back = console.box({ id: :console_back, blur: { value: 5, affect: :back }, overflow: :auto, width: :auto, height: :auto, top: 25, bottom: 0, left: 0, right: 0, depth: 30, color: { alpha: 0.5, red: 0, green: 0, blue: 0 } })
      console_top = console.box({ id: :console_top, overflow: :auto, width: :auto, height: 25, top: 0, bottom: 0, left: 0, right: 0, depth: 30, color: { alpha: 1, red: 0.3, green: 0.3, blue: 0.3 } })

      console_top.touch(:double) do
        console.height(25)
        console.bottom(0)
        console.top(:auto)
      end
      console_top.shadow({
                           id: :s1,
                           left: 0, top: 3, blur: 9,
                           invert: false,
                           red: 0, green: 0, blue: 0, alpha: 1
                         })
      console.drag(:locked) do |event|
        dy = event[:dy]
        y = console.to_px(:top) + dy.to_f
        console.top(y)
        console.height(:auto)
      end
      console_output = console_back.text({ data: '', id: :console_output, component: { size: 12 } })
      JS.eval <<~JS
        (function() {
          var oldLog = console.log;
          var consoleDiv = document.getElementById("console_output");
          console.log = function(message) {
            if (consoleDiv) {
              consoleDiv.innerHTML += '<p>' + message + '</p>';
            }
            oldLog.apply(console, arguments);
          };
        }());
      JS

      console_clear = console_top.circle({ id: :console_clear, color: :red, top: 3, left: 3, width: 19, height: 19 })
      console_clear.touch(true) do
        console_output.data("")
      end
      JS.global[:document].addEventListener("contextmenu") do |event|
      end
    else
      grab(:console_back).delete(true)
      JS.global[:document].addEventListener("contextmenu") do |native_event|
        event = Native(native_event)
        event.preventDefault
      end
    end
  end

  # import methode below
  def importer_all(&proc)
    JS.global[:document][:body].addEventListener('dragover') do |native_event|
      event = Native(native_event)
      event.preventDefault
    end

    JS.global[:document][:body].addEventListener('drop') do |native_event|
      event = Native(native_event)
      event.preventDefault
      files = event[:dataTransfer][:files]

      if files[:length].to_i > 0
        (0...files[:length].to_i).each do |i|
          file = files[i]
          reader = JS.eval('let a= new FileReader(); return a')
          reader.readAsText(file)
          reader.addEventListener('load') do
            proc.call({ content: reader[:result].to_s, name: file[:name].to_s, type: file[:type].to_s, size: file[:size].to_s })
          end
          reader.addEventListener('error') do
            puts 'Error: ' + file[:name].to_s
          end
        end
      end
    end
  end

  def exception_import(atome_id, &proc)
    if Universe.user_atomes.include?(atome_id.to_sym)
      special_div = JS.global[:document].getElementById(atome_id)
      special_div.addEventListener('dragover') do |native_event|
        event = Native(native_event)
        special_div[:style][:backgroundColor] = 'red'
        event.preventDefault
        event.stopPropagation
      end

      special_div.addEventListener('dragleave') do |native_event|
        event = Native(native_event)
        special_div[:style][:backgroundColor] = 'yellow'
        event.stopPropagation
      end

      special_div.addEventListener('drop') do |native_event|
        event = Native(native_event)
        event.preventDefault
        event.stopPropagation

        files = event[:dataTransfer][:files]

        if files[:length].to_i > 0
          (0...files[:length].to_i).each do |i|
            file = files[i]
            reader = JS.eval('let a= new FileReader(); return a')
            reader.readAsText(file)
            reader.addEventListener('load') do
              proc.call({ content: reader[:result].to_s, name: file[:name].to_s, type: file[:type].to_s, size: file[:size].to_s })
            end
            reader.addEventListener('error') do
              puts 'Error: ' + file[:name].to_s
            end
          end
        end
      end
      JS.global[:document][:body].addEventListener('drop') do |native_event|
        event = Native(native_event)
        event.preventDefault
        event.stopPropagation
      end
    end
  end

  def importer(target = :all, &proc)
    if target == :all
      importer_all(&proc)
    else
      exception_import(target, &proc)
    end
  end

  def infos
    particle_list = Universe.particle_list.dup
    particle_list.delete(:password)
    particle_list.delete(:selection)
    infos = {}
    particle_list[:css] = :poil
    particle_list.each do |particle_found|
      infos[particle_found[0]] = send(particle_found[0]) unless send(particle_found[0]).nil?
    end
    # we convert CssProxy object to hash below
    infos[:css] = eval(infos[:css].to_s)
    infos
  end

  def dig
    ids = []
    dig_recursive = lambda do |atome|
      ids << atome.id
      atome.fasten.each { |fasten_atome| dig_recursive.call(grab(fasten_atome)) }
    end
    dig_recursive.call(self)
    ids
  end

  # def fit(params)
  #   unless params.instance_of?(Hash)
  #     params = { value: params }
  #   end
  #   target_size = params[:value]
  #   axis = params[:axis]
  #   objet_atome = self
  #   atomes_found = objet_atome.dig
  #   total_width = found_area_used(atomes_found)[:max][:x] - found_area_used(atomes_found)[:min][:x]
  #   total_height = found_area_used(atomes_found)[:max][:y] - found_area_used(atomes_found)[:min][:y]
  #   if axis == :x
  #     ratio = target_size / total_width
  #     # now we resize and re-position all atomes
  #       atomes_found.each do |atome_id|
  #         current_atome = grab(atome_id)
  #         current_atome.left(current_atome.left * ratio)
  #       current_atome.top(current_atome.top * ratio)
  #       new_width = current_atome.to_px(:width) * ratio
  #       new_height = current_atome.to_px(:height) * ratio
  #       current_atome.width(new_width)
  #       current_atome.height(new_height)
  #     end
  #   else
  #     ratio = target_size / total_height
  #     # now we resize and re-position all atomes
  #
  #     atomes_found.each do |atome_id|
  #
  #       current_atome = grab(atome_id)
  #       # puts "#{current_atome}, #{atome_id}, left:  #{current_atome.left}, ratio: #{ratio}"
  #       current_atome.left(current_atome.left * ratio)
  #       current_atome.top(current_atome.top * ratio)
  #       current_atome.width(current_atome.to_px(:width) * ratio)
  #       current_atome.height(current_atome.to_px(:height) * ratio)
  #     end
  #   end
  # end

  def fit(params)
    params = { value: params } unless params.instance_of?(Hash)

    target_size = params[:value]
    axis = params[:axis]
    objet_atome = self
    atomes_found = objet_atome.dig

    found_area_used(atomes_found) do |result|
      total_width = result[:max][:x] - result[:min][:x]
      total_height = result[:max][:y] - result[:min][:y]

      ratio = if axis == :x
                target_size / total_width
              else
                target_size / total_height
              end

      atomes_found.each do |atome_id|
        current_atome = grab(atome_id)

        left = current_atome.left || 0
        top = current_atome.top || 0

        current_atome.left(left * ratio)
        current_atome.top(top * ratio)
        new_width = current_atome.to_px(:width) * ratio
        new_height = current_atome.to_px(:height) * ratio
        current_atome.width(new_width)
        current_atome.height(new_height)
      end
    end
  end

  # def found_area_used(ids)
  #   min_x, min_y = Float::INFINITY, Float::INFINITY
  #   max_x, max_y = 0, 0
  #   ids.each do |id|
  #     atome = grab(id)
  #     x = atome.compute({ particle: :left })[:value]
  #     y = atome.compute({ particle: :top })[:value]
  #     width = atome.to_px(:width)
  #     height = atome.to_px(:height)
  #     min_x = [min_x, x].min
  #     min_y = [min_y, y].min
  #     max_x = [max_x, x + width].max
  #     max_y = [max_y, y + height].max
  #   end
  #   { min: { x: min_x, y: min_y }, max: { x: max_x, y: max_y } }
  # end
  #############################
  def found_area_used(ids, &block)

    check_interval = 0.1

    wait(check_interval) do
      all_ready = ids.all? do |id|
        atome = grab(id)
        width = atome.to_px(:width).to_f rescue 0
        height = atome.to_px(:height).to_f rescue 0
        width > 0 && height > 0
      end
      if all_ready
        min_x, min_y = Float::INFINITY, Float::INFINITY
        max_x, max_y = 0, 0

        ids.each do |id|

          atome = grab(id)
          x = atome.compute({ particle: :left })[:value].to_f rescue 0
          y = atome.compute({ particle: :top })[:value].to_f rescue 0
          width = atome.to_px(:width).to_f rescue 0
          height = atome.to_px(:height).to_f rescue 0

          min_x = [min_x, x].min
          min_y = [min_y, y].min
          max_x = [max_x, x + width].max
          max_y = [max_y, y + height].max
        end

        result = { min: { x: min_x, y: min_y }, max: { x: max_x, y: max_y } }
        block.call(result) if block_given?
      else
        found_area_used(ids, &block)
      end
    end
  end

  ############################

  def calculate_total_size(objet_atome, axis)
    total_size = (axis == :x) ? objet_atome.to_px(:width) : objet_atome.to_px(:height)
    max_other_axis_size = (axis == :x) ? objet_atome.to_px(:height) : objet_atome.to_px(:width)
    objet_atome.fasten.each do |child_id|
      child = grab(child_id)
      child_size = (axis == :x) ? child.to_px(:width) : child.to_px(:height)
      other_axis_size = (axis == :x) ? child.to_px(:height) : child.to_px(:width)
      total_size += child_size
      max_other_axis_size = [max_other_axis_size, other_axis_size].max
    end
    [total_size, max_other_axis_size]
  end

  def resize_and_reposition(objet_atome, scale_factor, axis, max_other_axis_size)
    current_position = 0
    resize_object(objet_atome, scale_factor, axis, max_other_axis_size)
    current_position += (axis == :x) ? objet_atome.to_px(:width) : objet_atome.to_px(:height)
    objet_atome.fasten.each do |child_id|
      child = grab(child_id)
      resize_object(child, scale_factor, axis, max_other_axis_size)
      child.top(child.top * scale_factor)
      child.left(child.left * scale_factor)
      current_position += child.to_px(:height)
    end
  end

  def resize_object(objet, scale_factor, axis, max_other_axis_size)
    if axis == :x
      new_width = objet.width * scale_factor
      new_height = new_width / (objet.width.to_f / objet.height)
      objet.width(new_width)
      objet.height([new_height, max_other_axis_size].min)
    else
      new_height = objet.height * scale_factor
      new_width = new_height / (objet.height.to_f / objet.width)
      objet.height(new_height)
      objet.width([new_width, max_other_axis_size].min)
    end
  end

  def atomizer(params)
    params = { target: params } unless params.instance_of? Hash
    id = params[:id]
    id_wanted = if id
                  { id: id }
                else
                  {}
                end
    basis = { alien: params[:target], renderers: [:html], type: :atomized }.merge(id_wanted)
    a = Atome.new(basis)
    return a
    # convert any foreign object (think HTML) to a pseudo atome objet , that embed foreign objet
  end

  def allow_right_touch(allow)
    js_prevent = <<Str
disableRightClick();
Str

    js_allow = <<Str
  enableRightClick();

Str
    if allow == true
      JS.eval(js_allow)
    else
      JS.eval(js_prevent)
    end
  end

  def allow_copy(allow)
    if allow
      # allow selection and text copy
      JS.eval(<<~JS)
        document.body.style.userSelect = 'auto';  // allow text slectiion 
        document.removeEventListener('copy', preventDefaultAction);  // allow copy
      JS
    else
      # lock selection and text copy
      JS.eval(<<~JS)
        document.body.style.userSelect = 'none';  // prevent text selection
        document.addEventListener('copy', preventDefaultAction);  // prevent copy
      JS
    end
  end

  def above(parent, margin = 6, ref = grab(:view))
    item=grab(parent)
    # FIXME above is broken when using % in margin
    unless margin.is_a?(Numeric)
      item_height = ref.to_px(:height)
      margin = (margin.to_f * item_height) / 100
    end
    pos = item.to_px(:bottom) + item.height + margin
    item.top(:auto)
    if item.display == :none
      33
    else
      pos
    end
  end

  def below(parent, margin = 6, ref = grab(:view))
    item=grab(parent)
    unless margin.is_a?(Numeric)
      item_height = ref.to_px(:height)
      margin = (margin.to_f * item_height) / 100
    end
    pos = item.to_px(:top) + item.to_px(:height) + margin
    if item.display == :none
      0
    else
      pos
    end

  end

  def after(parent, margin = 6, ref = grab(:view))
    item=grab(parent)
    unless margin.is_a?(Numeric)
      item_width = ref.to_px(:width)
      margin = (margin.to_f * item_width) / 100
    end
    left_f = if item.left.instance_of?(Integer)
               item.left
             else
               item.to_px(:left)
             end

    width_f = if item.width.instance_of?(Integer)
                item.width
              else
                item.to_px(:width)
              end
    pos = left_f + width_f + margin
    if item.display == :none
      0
    else
      pos
    end
  end

  def before(parent, margin = 6, ref = grab(:view))
    item=grab(parent)
    unless margin.is_a?(Numeric)
      item_width = ref.to_px(:width)
      margin = (margin.to_f * item_width) / 100
    end
    pos = item.to_px(:right) + item.width + margin
    if item.display == :none
      0
    else
      pos
    end
  end

  # Helper method to store task configuration in localStorage
  def store_task(name, config)
    JS.global[:localStorage].setItem(name, config.to_json)
  end

  # Helper method to retrieve task configuration from localStorage
  def retrieve_task(name)
    config = JS.global[:localStorage].getItem(name)
    config.nil? ? nil : JSON.parse(config)
  end

  # Helper method to retrieve all tasks from localStorage
  def retrieve_all_tasks
    tasks = []
    local_storage = JS.global[:localStorage]
    if Atome::host == "web-opal"
      local_storage.each do |key|
        value = local_storage.getItem(key)
        if value
          value = JSON.parse(value)
          tasks << { name: key, config: value }
        end
      end
    else
      length = local_storage[:length].to_i
      length.times do |i|
        key = local_storage.call(:key, i)
        value = local_storage.call(:getItem, key)
        tasks << { name: key, config: JSON.parse(value.to_s) } if value
      end
    end
    tasks
  end

  # Helper method to schedule a task
  def schedule_task(name, years, month, day, hours, minutes, seconds, recurrence: nil, &block)
    target_time = Time.new(years, month, day, hours, minutes, seconds)
    now = Time.now

    if target_time < now
      schedule_recurrence(name, target_time, recurrence, &block)
    else
      seconds_until_target = target_time - now
      wait_task = wait(seconds_until_target) do
        block.call
        schedule_recurrence(name, target_time, recurrence, &block) if recurrence
      end
      store_task(name, { wait: wait_task, target_time: target_time, recurrence: recurrence })
    end
  end

  def schedule_recurrence(name, target_time, recurrence, &block)
    now = Time.now
    next_time = target_time

    case recurrence
    when :yearly
      next_time += 365 * 24 * 60 * 60 while next_time <= now
    when :monthly
      next_time = next_time >> 1 while next_time <= now
    when :weekly
      next_time += 7 * 24 * 60 * 60 while next_time <= now
    when :daily
      next_time += 24 * 60 * 60 while next_time <= now
    when :hourly
      next_time += 60 * 60 while next_time <= now
    when :minutely
      next_time += 60 while next_time <= now
    when :secondly
      next_time += 1 while next_time <= now
    when Hash
      if recurrence[:weekly]
        wday = recurrence[:weekly]
        next_time += 7 * 24 * 60 * 60 while next_time <= now
        next_time += 24 * 60 * 60 until next_time.wday == wday
      elsif recurrence[:monthly]
        week_of_month = recurrence[:monthly][:week]
        wday = recurrence[:monthly][:wday]
        while next_time <= now
          next_month = next_time >> 1
          next_time = Time.new(next_month.year, next_month.month, 1, target_time.hour, target_time.min, target_time.sec)
          next_time += 24 * 60 * 60 while next_time.wday != wday
          next_time += (week_of_month - 1) * 7 * 24 * 60 * 60
        end
      end
    else
      puts "Invalid recurrence option"
      return
    end

    seconds_until_next = next_time - Time.now
    wait_task = wait(seconds_until_next) do
      block.call
      schedule_recurrence(name, next_time, recurrence, &block)
    end
    store_task(name, { wait: wait_task, target_time: next_time, recurrence: recurrence })
  end

  # Helper method to stop a scheduled task
  def stop_task(name)
    task_config = retrieve_task(name)
    return unless task_config

    stop({ wait: task_config['wait'] })
    JS.global[:localStorage].removeItem(name)
  end

  # Method to relaunch all tasks from localStorage
  def relaunch_all_tasks
    tasks = retrieve_all_tasks

    tasks.each do |task|
      name = task[:name]
      config = task[:config]
      target_time_found = config['target_time']
      target_time = Time.parse(target_time_found)
      recurrence_found = config['recurrence']
      next unless recurrence_found
      recurrence = config['recurrence'].is_a?(Hash) ? config['recurrence'].transform_keys(&:to_sym) : config['recurrence'].to_sym
      schedule_task(name, target_time.year, target_time.month, target_time.day, target_time.hour, target_time.min, target_time.sec, recurrence: recurrence) do
        puts "Relaunched task  #{name}(add proc here)"
      end
    end
  end

  def reenact(id, action)
    atome_wanted = grab(id)
    atome_wanted.simulate(action) if atome_wanted
  end

end

class CssProxy
  def initialize(js, parent_key = nil, current_atome)
    @js = js
    @css = {}
    @parent_key = parent_key
    @style = {}
    @current_atome = current_atome
  end

  def [](key)
    if @parent_key
      @current_atome.instance_variable_get('@css')[@parent_key]&.[](key)
    else
      CssProxy.new(@js, key, @current_atome)
    end
  end

  def []=(key, value)
    if @parent_key
      @js[@parent_key][key] = value
      @current_atome.instance_variable_set('@css', { @parent_key => { key => value } })
      @css[@parent_key] = { key => value }
      puts "==> parent key: #{@parent_key}, Clé: #{key}, value: #{value}"
    else
      @style[key] = value
      @js[key] = value
    end

    @js.update_style(@style) if @parent_key.nil?
  end

  def to_s
    @current_atome.instance_variable_get('@css').to_s
  end

  def receptor(msg, &bloc)
    parsed = JSON.parse(msg)
    bloc.call(parsed)
  end

end

def timer_callback(val, id)
  # alert((val.to_s)+" : "+ id)
  proc_found = grab(id).instance_variable_get("@timer_callback")
  proc_found.call(val) if proc_found.is_a? Proc
end

# def js_timer(start, stop, id)
#
#   js_timer = <<STR
# let start = #{start}
# let stop =#{stop}
#   if (start >= stop) {
#     throw new Error("Start must be less than Stop");
#   }
#   let position = start;
#   const advance = () => {
#     if (position <= stop) {
# atomeJsToRuby("timer_callback("+position+",'#{id}')")
#       position += 1;
#       setTimeout(advance, 1);
#     }
#   };
#   advance();
#
# STR
#   JS.eval(js_timer)
# end

def js_timer(start, stop = nil, id = nil)
  id ||= "default_timer" # Assurez-vous d'avoir un identifiant par défaut si `id` est nil

  if start == 'kill'
    kill_timer_js = <<~STR
            // Log the last position before killing
      //var last_position= window['#{id}_last_position']
            //console.log("Last position before kill:"+ last_position);
           // atomeJsToRuby("timer_callback(" + last_position + ",'#{id}')");
            // Clear the timeout and stop the timer
            if (window['#{id}_timeout_id']) {
              clearTimeout(window['#{id}_timeout_id']);
              window['#{id}_timeout_id'] = null;
            }
            window['#{id}_stop'] = true;
    STR
    JS.eval(kill_timer_js)
    return
  end

  js_timer = <<~STR
    let start = #{start};
    let stop = #{stop};
  
    let position = start;
    window['#{id}_stop'] = false;
    // window['#{id}_last_position'] = position; // Initialize last_position with the starting value

    const advance = () => {
      if (position <= stop && !window['#{id}_stop']) {
        // Log current position and callback
        atomeJsToRuby("timer_callback(" + position + ",'#{id}')");
        // console.log(position);
        
        // Update last_position with the current position
        window['#{id}_last_position'] = position;
        
        position += 1;
        window['#{id}_timeout_id'] = setTimeout(advance, 1);
      }
    };
    advance();
  STR
  JS.eval(js_timer)
end

#### Attention super precise timer, below  but  it lock the CPU
# def js_timer(start, stop, id)
#   js_timer = <<STR
# let start = #{start};
# let stop = #{stop};
#
# if (start >= stop) {
#   throw new Error("Start must be less than Stop");
# }
#
# let position = start;
# let lastTime = performance.now();
#
# const advance = () => {
#   let now = performance.now();
#   let elapsed = now - lastTime;
#
#   // Calculer combien d'incréments ajouter en fonction du temps écoulé
#   let increments = Math.floor(elapsed);
#   lastTime = now;
#
#   for (let i = 0; i < increments; i++) {
#     if (position <= stop) {
#       atomeJsToRuby("timer_callback(" + position + ",'#{id}')");
#       position += 1;
#     }
#   }
#
#   // Continue seulement si on n'a pas atteint la fin
#   if (position <= stop) {
#     requestAnimationFrame(advance);
#   }
# };
#
# requestAnimationFrame(advance);
# STR
#
#   JS.eval(js_timer)
# end


