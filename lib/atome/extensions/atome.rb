# frozen_string_literal: true

module ObjectExtension


  def new(params, &bloc)
    # Genesis = Genesis.Genesis
    if params.key?(:atome)
      # if Universe.atome_list.include?(params[:atome])
      #   puts "atome #{params[:atome]} already exist you can't create it"
      # else
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
      # elsif params.key?(:callback)
      #   particle_targetted = params[:callback]
      #   Atome.define_method("#{particle_targetted}_callback", option) do
      #     alert option
      #     bloc.call(option)
      #   end
    elsif params.key?(:molecule)
      molecule=params[:molecule]
      Genesis.build_molecule(molecule, &bloc)
      Universe.add_to_molecule_list(molecule)
    elsif params.key?(:tool)
      A.build_tool(&bloc)
    elsif params.key?(:template)
      A.build_template(&bloc)
    elsif params.key?(:code)
      A.build_code(&bloc)
    elsif params.key?(:test)
      A.build_test(&bloc)
    end
    super if defined?(super)
  end

end
# atome extensions
class Object
  include ObjectExtension
  # def new(params, &bloc)
  #   # Genesis = Genesis.Genesis
  #   if params.key?(:atome)
  #     if Universe.atome_list.include?(params[:atome])
  #       puts "atome #{params[:atome]} already exist you can't create it"
  #     else
  #       Universe.add_atomes_specificities params[:atome]
  #       Genesis.build_atome(params[:atome], &bloc)
  #     end
  #   elsif params.key?(:particle)
  #     if Universe.particle_list[params[:particle]]
  #       puts "particle #{params[:particle]} already exist you can't create it"
  #     else
  #       Atome.instance_variable_set("@main_#{params[:particle]}", bloc)
  #       # render indicate if the particle needs to be rendered
  #       # store tell the system if it need to store the particle value
  #       # type help the system what type of type the particle will receive and store
  #       Genesis.build_particle(params[:particle], { render: params[:render], return: params[:return],
  #                                                   store: params[:store], type: params[:type],
  #                                                   category: params[:category] }, &bloc)
  #     end
  #
  #   elsif params.key?(:sanitizer)
  #     Genesis.build_sanitizer(params[:sanitizer], &bloc)
  #   elsif params.key?(:pre)
  #     Atome.instance_variable_set("@pre_#{params[:pre]}", bloc)
  #   elsif params.key?(:post)
  #     Atome.instance_variable_set("@post_#{params[:post]}", bloc)
  #   elsif params.key?(:after)
  #     Atome.instance_variable_set("@after_#{params[:after]}", bloc)
  #   elsif params.key?(:read)
  #     Atome.instance_variable_set("@read_#{params[:read]}", bloc)
  #   elsif params[:renderer]
  #     renderer_found = params[:renderer]
  #     if params[:specific]
  #       Universe.set_atomes_specificities(params)
  #       params[:specific] = "#{params[:specific]}_"
  #     end
  #     render_method = "#{renderer_found}_#{params[:specific]}#{params[:method]}"
  #     Genesis.build_render(render_method, &bloc)
  #   # elsif params.key?(:callback)
  #   #   particle_targetted = params[:callback]
  #   #   Atome.define_method("#{particle_targetted}_callback", option) do
  #   #     alert option
  #   #     bloc.call(option)
  #   #   end
  #   end
  # end

  def reorder_particles(hash_to_reorder)
    # we reorder the hash
    ordered_keys = %i[renderers id alien type attach int8 unit]

    ordered_part = ordered_keys.map { |k| [k, hash_to_reorder[k]] }.to_h
    other_part = hash_to_reorder.reject { |k, _| ordered_keys.include?(k) }
    # merge the parts  to obtain an re-ordered hash
   ordered_part.merge(other_part)
    # reordered_hash
  end

  def delete (atomes)
    grab(:view).delete(atomes)
  end

  def identity_generator
    "a_#{Universe.app_identity}_#{Universe.counter}".to_sym
  end

  def hook(a_id)
    a_id=a_id.to_sym
    Universe.atomes[a_id]
  end

  def grab(id_to_get)
    id_to_get=id_to_get.to_sym
    return if id_to_get == false
    aid_to_get= Universe.atomes_ids[id_to_get]
    # puts id_to_get.class
    # alert Universe.atomes
    aid_to_get = '' if aid_to_get.instance_of? Array
    # id_to_get = id_to_get.to_sym

    # if id_to_get.nil? do
    # if aid_to_get.nil?
    #   alert   id_to_get
    # else

    # end
    # end
    # alert Universe.atomes[id_to_get]
    Universe.atomes[aid_to_get]
  end

  def box(params = {}, &proc)
    grab(:view).box(params, &proc)
  end

  # def intuition(params = {}, &proc)
  #   grab(:view).intuition(params, &proc)
  # end

  def circle(params = {}, &proc)
    grab(:view).circle(params, &proc)
  end

  # the method below generate Atome method creation at Object level
  def atome_method_for_object(element)
    Object.define_method element do |params, &user_proc|
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

  def repeater(counter, proc)
    instance_exec(counter, &proc) if proc.is_a?(Proc)
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
               rubyVMCallback("repeat_callback(#{repeat_id}, "+counter+")")
           }

           const intervalId = repeat(myAction, #{delay} * 1000, #{repeat}); 

      return intervalId;
    JS

  end

  def stop(params)
    case params
    when Hash
      if params.key?(:repeat)
        repeater_to_stop = params[:repeat]
        JS.eval(<<~JS)
          clearInterval(#{repeater_to_stop});
        JS
      else
        puts "La clé :repeat n'existe pas dans params"
      end
    else
      puts "params n'est pas un hash"
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
                           # affect: [:the_circle],
                           left: 0, top: 3, blur: 9,
                           invert: false,
                           red: 0, green: 0, blue: 0, alpha: 1
                         })
      console.drag(:locked) do |event|
        dy = event[:dy]
        y = console.to_px(:top) + dy.to_f
        console.top(y)
        console.height(:auto)
        total_height = grab(:view).to_px(:height)
        # console_back.height(total_height-console.top)
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
      # element[:style][:WebkitUserSelect] = 'none'
      # element[:style][:MozUserSelect] = 'none'
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
        # puts 'File drop out of the special zonne'
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
    particle_list[:css]=:poil
    particle_list.each do |particle_found|
      infos[particle_found[0]] = send(particle_found[0]) unless send(particle_found[0]).nil?
    end
    # we convert CssProxy object to hash below
    infos[:css]=eval(infos[:css].to_s)
    infos
  end

  def dig
    ids = []
    dig_recursive = lambda do |atome|
      ids << atome.id
      atome.attached.each { |attached_atome| dig_recursive.call(grab(attached_atome)) }
    end
    dig_recursive.call(self)
    ids
  end

  def fit(params)
    unless params.instance_of?(Hash)
      params = { value: params }
    end
    target_size = params[:value]
    axis = params[:axis]
    objet_atome = self
    atomes_found = objet_atome.dig
    total_width = found_area_used(atomes_found)[:max][:x] - found_area_used(atomes_found)[:min][:x]
    total_height = found_area_used(atomes_found)[:max][:y] - found_area_used(atomes_found)[:min][:y]
    if axis == :x
      ratio = target_size / total_width
      # now we resize and re-position all atomes
      atomes_found.each do |atome_id|
        current_atome = grab(atome_id)
        current_atome.left(current_atome.left * ratio)
        current_atome.top(current_atome.top * ratio)
        new_width = current_atome.to_px(:width) * ratio
        new_height = current_atome.to_px(:height) * ratio
        current_atome.width(new_width)
        current_atome.height(new_height)
      end
    else
      ratio = target_size / total_height
      # now we resize and re-position all atomes
      atomes_found.each do |atome_id|
        current_atome = grab(atome_id)
        current_atome.left(current_atome.left * ratio)
        current_atome.top(current_atome.top * ratio)
        current_atome.width(current_atome.to_px(:width) * ratio)
        current_atome.height(current_atome.to_px(:height) * ratio)
      end
    end
    # total_size, max_other_axis_size = calculate_total_size(objet_atome, axis)
    # scale_factor = target_size.to_f / total_size
    # resize_and_reposition(objet_atome, scale_factor, axis, max_other_axis_size)
  end

  def found_area_used(ids)

    min_x, min_y = Float::INFINITY, Float::INFINITY
    max_x, max_y = 0, 0

    ids.each do |id|
      atome = grab(id)

      x = atome.compute({ particle: :left })[:value]
      y = atome.compute({ particle: :top })[:value]
      width = atome.to_px(:width)
      height = atome.to_px(:height)
      min_x = [min_x, x].min
      min_y = [min_y, y].min
      max_x = [max_x, x + width].max
      max_y = [max_y, y + height].max
    end

    { min: { x: min_x, y: min_y }, max: { x: max_x, y: max_y } }

  end

  def calculate_total_size(objet_atome, axis)
    total_size = (axis == :x) ? objet_atome.to_px(:width) : objet_atome.to_px(:height)
    max_other_axis_size = (axis == :x) ? objet_atome.to_px(:height) : objet_atome.to_px(:width)

    objet_atome.attached.each do |child_id|
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
    objet_atome.attached.each do |child_id|
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
    unless params.instance_of? Hash
      params = { target: params }
    end
    id = params[:id]
    if id
      id_wanted = { id: id }
    else
      id_wanted = {}
    end
    basis = { alien: params[:target], renderers: [:html], type: :atomized }.merge(id_wanted)
    a = Atome.new(basis)
    return a
    # convert any foreign object (think HTML) to a pseudo atome objet , that embed foreign objet
  end


  JS.eval(<<~JS)
  window.preventDefaultAction = function(e) {
    e.preventDefault();
  }
JS

  def touch_allow(allow)
    if allow
      # Retire l'écouteur d'événements en utilisant la fonction globale
      JS.eval('document.removeEventListener("contextmenu", window.preventDefaultAction);')
    else
      # Ajoute l'écouteur d'événements en utilisant la fonction globale
      JS.eval('document.addEventListener("contextmenu", window.preventDefaultAction);')
    end
  end


  def allow_copy(allow)
    if allow
      # Rétablir la sélection et la copie de texte
      JS.eval(<<~JS)
      document.body.style.userSelect = 'auto';  // Permet la sélection de texte
      document.removeEventListener('copy', preventDefaultAction);  // Permet la copie
    JS
    else
      # Bloquer la sélection et la copie de texte
      JS.eval(<<~JS)
      document.body.style.userSelect = 'none';  // Bloque la sélection de texte
      document.addEventListener('copy', preventDefaultAction);  // Bloque la copie
    JS
    end
  end

  # Définit la fonction preventDefaultAction dans un contexte global pour être utilisée par allow_copy
  JS.eval(<<~JS)
  window.preventDefaultAction = function(e) {
    e.preventDefault();
  }
JS


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
      puts "==> Clé parente: #{@parent_key}, Clé: #{key}, Valeur: #{value}"
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


