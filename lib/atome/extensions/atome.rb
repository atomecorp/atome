# frozen_string_literal: true

# atome extensions
class Object
  def new(params, &bloc)
    # Genesis = Genesis.Genesis
    if params.key?(:atome)
      Universe.add_atomes_specificities params[:atome]
      Genesis.build_atome(params[:atome], &bloc)
    elsif params.key?(:particle)
      Atome.instance_variable_set("@main_#{params[:particle]}", bloc)
      # render indicate if the particle needs to be rendered
      # store tell the system if it need to store the particle value
      # type help the system what type of type the particle will receive and store
      Genesis.build_particle(params[:particle], { render: params[:render], return: params[:return],
                                                  store: params[:store], type: params[:type] }, &bloc)
    elsif params.key?(:sanitizer)
      Genesis.build_sanitizer(params[:sanitizer], &bloc)
    elsif params.key?(:pre)
      Atome.instance_variable_set("@pre_#{params[:pre]}", bloc)
    elsif params.key?(:post)
      Atome.instance_variable_set("@post_#{params[:post]}", bloc)
    elsif params.key?(:after)
      Atome.instance_variable_set("@after_#{params[:after]}", bloc)
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
    elsif params.key?(:callback)
      particle_targetted = params[:callback]
      Atome.define_method "#{particle_targetted}_callback" do
        bloc.call
      end
    end
  end

  def delete (atomes)
    grab(:view).delete(atomes)
  end

  def identity_generator(type_needed = :element)
    "#{type_needed}_#{Universe.counter}"
  end

  def grab(id_to_get)
    return if id_to_get == false

    id_to_get = '' if id_to_get.instance_of? Array
    id_to_get = id_to_get.to_sym
    Universe.atomes[id_to_get]
  end

  def box(params = {}, &proc)
    grab(:view).box(params, &proc)
  end

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
    intervalId = JS.eval(<<~JS)
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
    intervalId

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
      if element
        element.addEventListener("mouseenter") { $current_hovered_element = element_id }
        element.addEventListener("mouseleave") { $current_hovered_element = nil }
      end
    end

    JS.global[:document].addEventListener("keydown") do |native_event|
      event = Native(native_event)
      key_pressed = event[:key].downcase
      ctrl_pressed = event[:ctrlKey]
      alt_pressed = event[:altKey]
      meta_pressed = event[:metaKey]

      modifier_matched = case option
                         when :ctrl then ctrl_pressed
                         when :alt then alt_pressed
                         when :meta then meta_pressed
                         else true
                         end

      affect_condition = affect == :all || Array(affect).include?($current_hovered_element)
      exclude_condition = !Array(exclude).include?($current_hovered_element)
      if $current_hovered_element.nil?
        $current_hovered_element=:view
      end
      if key_pressed == key.to_s.downcase && modifier_matched && affect_condition && exclude_condition
        block.call(key_pressed, $current_hovered_element)
      end
    end
  end

  def console(debug)
    if debug
      console=box({id: :console,  width: :auto, height:225, bottom: 0,top: :auto, left: 0,right: 0,depth: 30, color: {alpha: 0, red: 0.1, green: 0.3 , blue:0.3}})
      console_back=console.box({id: :console_back,blur: { value: 10, affect: :back}, overflow: :auto, width: :auto, height: :auto, top: 25, bottom: 0,left: 0,right: 0, depth: 30, color: {alpha: 0.3, red: 1, green: 1 , blue: 1}})
      console_top=console.box({id: :console_top,overflow: :auto, width: :auto, height:25, top: 0, bottom: 0,left: 0,right: 0, depth: 30, color: {alpha: 1, red: 0.3, green: 0.3 , blue: 0.3}})

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
        y =  console.to_px(:top)+dy.to_f
        console.top(y)
        console.height(:auto)
        total_height=grab(:view).to_px(:height)
        # console_back.height(total_height-console.top)
      end
      console_output=console_back.text({data: '', id: :console_output, component: {size: 12}})
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

      console_clear=console_top.circle({id: :console_clear, color: :red, top: 3, left: 3, width: 19, height:19})
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

end
