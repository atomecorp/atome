# frozen_string_literal: true
#  this class is aimed at html rendering
class HTML

  def initialize(id_found, current_atome)
    @element ||= JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @original_atome = current_atome
  end

  def hypertext(params)
    current_div = JS.global[:document].getElementById(@id.to_s)
    current_div[:innerHTML] = params
  end

  def add_css_to_atomic_style(css)
    style_element = JS.global[:document].getElementById('atomic_style')
    text_node = JS.global[:document].createTextNode(css)
    style_element.appendChild(text_node)
  end

  def convert_to_css(data)
    conditions = data[:condition]
    apply = data[:alterations]

    # Convert the conditions
    condition_strings = []

    if conditions[:max]
      condition_strings << "(max-width: #{conditions[:max][:width]}px)" if conditions[:max][:width]
      condition_strings << "(max-height: #{conditions[:max][:height]}px)" if conditions[:max][:height]
    end

    if conditions[:min]
      condition_strings << "(min-width: #{conditions[:min][:width]}px)" if conditions[:min][:width]
      condition_strings << "(min-height: #{conditions[:min][:height]}px)" if conditions[:min][:height]
    end

    operator = conditions[:operator] == :and ? "and" : "or"

    # Convert properties to apply
    property_strings = []
    apply.each do |key, values|
      inner_properties = []
      values.each do |property, value|
        if property == :color
          inner_properties << "background-color: #{value} !important;"
        else
          inner_properties << "#{property}: #{value}px !important;" if value.is_a?(Integer)
          inner_properties << "#{property}: #{value} !important;" if value.is_a?(Symbol)
        end
      end
      # Prefix each key with "#"
      property_strings << "##{key} {\n#{inner_properties.join("\n")}\n}"
    end

    # let it build
    css = "@media #{condition_strings.join(" #{operator} ")} {\n#{property_strings.join("\n")}\n}"
    add_css_to_atomic_style(css)
    css
  end

  def css_to_data(css)
    data = {
      :condition => {},
      :apply => {}
    }
    # Extract conditions
    media_conditions = css.match(/@media ([^\{]+)/)[1].split(',').map(&:strip)
    media_conditions.each do |condition|
      type = condition.match(/(max|min)-/)[1].to_sym
      property = condition.match(/(width|height)/)[1].to_sym
      value = condition.match(/(\d+)/)[1].to_i

      data[:condition][type] ||= {}
      data[:condition][type][property] = value
    end

    # Extract properties to be applied
    css.scan(/(\w+) \{([^\}]+)\}/).each do |match|
      key = match[0].to_sym
      properties = match[1].split(';').map(&:strip).reject(&:empty?)

      data[:apply][key] ||= {}
      properties.each do |property|
        prop, value = property.split(':').map(&:strip)
        if prop == "background-color"
          data[:apply][key][:color] = value.to_sym
        elsif value[-2..] == "px"
          data[:apply][key][prop.to_sym] = value.to_i
        else
          data[:apply][key][prop.to_sym] = value.to_sym
        end
      end
    end

    data
  end

  def extract_properties(properties_string)
    properties_hash = {}
    properties = properties_string.split(';').map(&:strip).reject(&:empty?)
    properties.each do |property|
      key, value = property.split(':').map(&:strip)
      properties_hash[key] = value
    end
    properties_hash
  end

  def get_page_style
    main_view = JS.global[:document].getElementById('view')
    main_view_content = main_view[:innerHTML].to_s
    style_tags = main_view_content.split(/<\/?style[^>]*>/i).select.with_index { |_, index| index.odd? }
    style_tags = style_tags.join('')
    style_tags = style_tags.split("\n")
    hash_result = {}
    inside_media = false
    media_hash = {}

    style_tags.each do |line|
      line = line.strip
      next if line.empty? || line.start_with?("/*")

      if inside_media
        if line == "}"
          hash_result["@media"] << media_hash
          inside_media = false
          next
        end

        selector, properties = line.split('{').map(&:strip)
        next unless properties&.end_with?("}")

        properties = properties[0...-1].strip
        media_hash[selector] = extract_properties(properties)
      elsif line.start_with?("@media")
        media_content = line.match(/@media\s*\(([^)]+)\)\s*{/)
        next unless media_content

        media_query = media_content[1]
        hash_result["@media"] = [media_query]
        inside_media = true
      else
        selector, properties = line.split('{').map(&:strip)
        next unless properties&.end_with?("}")

        properties = properties[0...-1].strip
        hash_result[selector] = extract_properties(properties)
      end
    end
    hash_result
  end

  def hyperedit(params)
    html_object = JS.global[:document].getElementById(params.to_s)
    particles_from_style = {}
    # we get all the styles tag present in the page
    get_page_style
    if html_object[:className].to_s
      classes_found = html_object[:className].to_s.split(' ')
      classes_found.each do |class_found|
        if get_page_style[".#{class_found}"]
          particles_from_style = particles_from_style.merge(get_page_style[".#{class_found}"])
        end
      end
    end

    particles_found = {}
    particles_found[:data] = html_object[:innerText].to_s.chomp
    particles_found[:markup] = html_object[:tagName].to_s

    style_found = html_object[:style][:cssText].to_s

    style_found.split(';').each do |pair|
      key, value = pair.split(':').map(&:strip)
      particles_from_style[key.to_sym] = value if key && value
    end
    particles_found = particles_found.merge(particles_from_style)
    current_atome = grab(@id)
    current_atome.callback({ hyperedit: particles_found })
    current_atome.call(:hyperedit)

  end

  def match(params)
    css_converted = convert_to_css(params)
    css_to_data(css_converted)
  end

  def connect(params, &bloc)
    JS.eval("atomeJS.connect('ws://#{params}')")
  end

  def send_message(message)
    JS.eval("atomeJS.ws_sender('#{message}')")
  end

  def close_websocket
    @websocket.close
  end

  def attr(attribute, value)
    @element.setAttribute(attribute.to_s, value.to_s)
    self
  end

  def add_class(class_to_add)
    @element[:classList].add(class_to_add.to_s)
    self
  end

  def id(id)
    attr('id', id)
    self
  end

  def check_double(id)
    # we remove any element if the id already exist
    element_to_delete = JS.global[:document].getElementById(id.to_s)
    delete(id) unless element_to_delete.inspect == 'null'
  end

  def shape(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :div
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def text(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :pre
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def image(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :img
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def video(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :video
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def www(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :iframe
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    @element.setAttribute('src', 'https://www.youtube.com/embed/lLeQZ8Llkso?si=MMsGBEXELy9yBl9R')
    # below we get image to feed width and height if needed
    # image = JS.global[:Image].new
    self.id(id)
    self
  end

  def raw(id)
    # we remove any element if the id already exist
    check_double(id)
    @element = JS.global[:document].createElement('div')
    add_class('atome')
    self.id(id)
    JS.global[:document][:body].appendChild(@element)
    self
  end

  def svg(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || 'svg'
    @element_type = markup_found.to_s
    svg_ns = "http://www.w3.org/2000/svg"
    @element = JS.global[:document].createElementNS(svg_ns, "svg")
    JS.global[:document][:body].appendChild(@element)
    @element.setAttribute('viewBox', '0 0 1024 1024')
    @element.setAttribute('version', '1.1')
    add_class('atome')
    self.id(id)
    self
  end

  def svg_data(data)
    data.each do |type_passed, datas|
      svg_ns = "http://www.w3.org/2000/svg"
      new_path = JS.global[:document].createElementNS(svg_ns.to_s, type_passed.to_s)
      JS.global[:document][:body].appendChild(new_path)
      datas.each do |property, value|
        new_path.setAttribute(property.to_s, value.to_s)
      end
      @element.appendChild(new_path)
    end
  end

  def update_svg_data(data)
    data.each do |type_passed, datas|
      element_to_update = JS.global[:document].getElementById(type_passed.to_s)
      datas.each do |property, value|
        element_to_update.setAttribute(property.to_s, value.to_s)
      end
    end
  end

  def colorize_svg_data(data)
    command = <<-JS
       let svgElement = document.getElementById("#{@id}");
      if (!svgElement) {
        return [];
      }
      var children = svgElement.children;
      var ids = [];
      for (var i = 0; i < children.length; i++) {
        var element = document.getElementById(children[i].id); // Récupérer l'élément par son ID
        if (element) {
            element.setAttribute('fill', '#{data}'); // Modifier l'attribut fill
            element.setAttribute('stroke', '#{data}'); // Modifier l'attribut stroke
        }
        ids.push(children[i].id);
      }
  return ids
    JS
    JS.eval(command)
  end


  def raw_data(html_string)
    @element[:innerHTML] = html_string
  end

  def video_path(video_path, type = 'video/mp4')
    source = JS.global[:document].createElement('source')
    source.setAttribute('src', video_path)
    source.setAttribute('type', type)
    @element.appendChild(source)
  end

  def sanitize_text(text)
    text.to_s
        .gsub('&', '&amp;')
        .gsub('<', '&lt;')
        .gsub('>', '&gt;')
        .gsub('"', '&quot;')
        .gsub("'", '&apos;')
  end

  def innerText(data)
    sanitized_data = sanitize_text(data.to_s)
    @element[:innerText] = sanitized_data
  end

  def textContent(data)
    @element[:textContent] = data
  end

  def path(objet_path)
    @element.setAttribute('src', objet_path)
    # below we get image to feed width and height if needed
    # image = JS.global[:Image].new
    @element[:src] = objet_path
    @element[:onload] = lambda do |_event|
      @element[:width]
      @element[:height]
    end
  end

  def transform(property, value = nil)
    transform_needed = "#{property}(#{value}deg)"
    @element[:style][:transform] = transform_needed.to_s
  end

  def style(property, value = nil)
    if value
      @element[:style][property] = value.to_s
    elsif value.nil?
      @element[:style][property]
    else
      # If value is explicitly set to false, remove the property
      command = "document.getElementById('#{@id}').style.removeProperty('#{property}')"
      JS.eval(command)
    end
  end

  def filter(property, value)
    filter_needed = "#{property}(#{value})"
    @element[:style][:filter] = filter_needed
  end

  def currentTime(time)
    @element[:currentTime] = time
  end

  def action(_ction_call)
    # line below doesn't work width opal
    # @element.send("#{action_call}()")
    JS.eval("document.getElementById('#{@id}').play();")
  end

  def append_to(parent_id_found)
    parent_found = JS.global[:document].getElementById(parent_id_found.to_s)
    parent_found.appendChild(@element)
    self
  end

  def visible(param)
    @element[:style][:display] = param.to_s
  end

  def delete(id_to_delete)
    element_to_delete = JS.global[:document].getElementById(id_to_delete.to_s)
    element_to_delete.remove if element_to_delete
  end

  def append(child_id_found)
    child_found = JS.global[:document].getElementById(child_id_found.to_s)
    @element.appendChild(child_found)
    self
  end

  ###### event handler ######
  def on(property, bloc)
    property = property.to_s

    if property.start_with?('media:')
      # Extraire la requête média de la propriété
      media_query = property.split(':', 2).last

      mql = JS.global[:window].matchMedia(media_query)

      event_handler = ->(event) do
        bloc.call({ matches: event[:matches] }) if bloc.is_a? Proc
      end

      # Ajouter un écouteur à l'objet matchMedia
      mql.addListener(event_handler)

    elsif property == 'resize'
      event_handler = ->(event) do
        width = JS.global[:window][:innerWidth]
        height = JS.global[:window][:innerHeight]
        bloc.call({ width: width, height: height }) if bloc.is_a? Proc
      end
      JS.global[:window].addEventListener('resize', event_handler)
    else
      event_handler = ->(event) do
        bloc.call(event) if bloc.is_a? Proc
      end
      @element.addEventListener(property, event_handler)
    end
  end

  def keyboard_keypress(bloc)
    keypress_handler = ->(event) do
      if @original_atome.keyboard[:kill] == true
        Native(event).preventDefault()
      elsif bloc.is_a? Proc
        bloc.call(event)
      end
    end
    @element.addEventListener('keypress', keypress_handler)
  end

  def keyboard_keydown(bloc)
    keypress_handler = ->(event) do
      if @original_atome.keyboard[:kill] == true
        Native(event).preventDefault()
      elsif bloc.is_a? Proc
        bloc.call(event)
      end
    end
    @element.addEventListener('keydown', keypress_handler)
  end

  def keyboard_keyup(bloc)
    keypress_handler = ->(event) do
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      elsif bloc.is_a? Proc
        # we update the @data of the atome
        # @original_atome.instance_variable_set('@data',@element[:innerText].to_s)
        bloc.call(event)
      end
    end
    @element.addEventListener('keyup', keypress_handler)
  end

  def keyboard_kill(bloc)
    bloc.call if bloc.is_a? Proc
  end

  def keyboard_input(bloc)
    input_handler = ->(event) do
      if @original_atome.keyboard[:kill] == true
        Native(event).preventDefault()
      elsif Native(event)[:target]
        input_content = Native(event)[:target][:textContent] # Obtenez le contenu textuel de l'élément <pre>
        bloc.call(input_content) if bloc.is_a? Proc
      end

    end
    @element.addEventListener('input', input_handler)
  end

  def event(action, options)
    send("#{action}_#{options}")
  end

  def drag_false(val)
    interact = JS.eval("return interact('##{@id}')")
    interact.unset
  end

  def drag_start()
    interact = JS.eval("return interact('##{@id}')")
    interact.on('dragstart', lambda do |_native_event|
      bloc.call if bloc.is_a? Proc
    end)
  end

  def drag_end()
    interact = JS.eval("return interact('##{@id}')")
    interact.on('dragend', lambda do |_native_event|
      bloc.call if bloc.is_a? Proc
    end)
  end

  def drag_move()
    interact = JS.eval("return interact('##{@id}')")
    interact.draggable({
                         drag: true,
                         inertia: { resistance: 12,
                                    minSpeed: 200,
                                    endSpeed: 100 },
                       })

    JS.eval(<<-JS)
      interact('##{@id}').draggable({
        drag: true,
        modifiers: [
          interact.modifiers.restrict({
            restriction: 'parent',
            endOnly: true
          })
        ]
      });
    JS

    interact.on('dragmove', lambda do |native_event|
      # # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
      event = Native(native_event)
      puts @original_atome.inspect
      puts @original_atome.instance_variable_get('@drag_code')
      # bloc.call(event) if bloc.instance_of? Proc
      dx = event[:dx]
      dy = event[:dy]
      x = (@original_atome.left || 0) + dx.to_f
      y = (@original_atome.top || 0) + dy.to_f
      @original_atome.left(x)
      @original_atome.top(y)
    end)
  end

  def drag_lock(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.draggable({
                         drag: true,
                         inertia: { resistance: 12,
                                    minSpeed: 200,
                                    endSpeed: 100 },
                       })

    JS.eval(<<-JS)
      interact('##{@id}').draggable({
        drag: true,
        modifiers: [
          interact.modifiers.restrict({
            restriction: 'parent',
            endOnly: true
          })
        ]
      });
    JS

    interact.on('dragmove', lambda do |native_event|
      # # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
      event = Native(native_event)
      bloc.call(event) if bloc.instance_of? Proc
    end)
  end

  def drop_action(native_event, bloc)
    event = Native(native_event)
    draggable_element = event[:relatedTarget][:id].to_s
    dropzone_element = event[:target][:id].to_s
    bloc.call({ source: draggable_element, destination: dropzone_element }) if bloc.is_a? Proc

  end

  def drop_activate(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.dropzone({
                        # accept: nil, # Accept any element
                        # overlap: 0.75,
                        ondropactivate: lambda do |native_event|
                          drop_action(native_event, bloc)
                        end
                      })
  end

  def drop_deactivate(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.dropzone({
                        # accept: nil, # Accept any element
                        # overlap: 0.75,
                        ondropdeactivate: lambda do |native_event|
                          drop_action(native_event, bloc)
                        end
                      })
  end

  def drop_true(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.dropzone({
                        # accept: nil, # Accept any element
                        overlap: 0.75,
                        ondrop: lambda do |native_event|
                          drop_action(native_event, bloc)
                        end
                      })
  end

  def drop_enter(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.dropzone({
                        # accept: nil,
                        overlap: 0.001,
                        ondragenter: lambda do |native_event|
                          drop_action(native_event, bloc)
                        end
                      })
  end

  def drop_leave(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.dropzone({
                        # accept: nil,
                        # overlap: 0.75,
                        ondragleave: lambda do |native_event|
                          drop_action(native_event, bloc)
                        end
                      })
  end

  def resize(params, bloc)
    interact = JS.eval("return interact('##{@id}')")
    min_width = params[:min][:width]
    min_height = params[:min][:height]
    max_width = params[:max][:width]
    max_height = params[:max][:height]

    interact.resizable({
                         edges: { left: true, right: true, top: true, bottom: true },
                         inertia: true,
                         modifiers: [],
                         listeners: {

                           move: lambda do |native_event|
                             event = Native(native_event)
                             if bloc.instance_of? Proc
                               bloc.call({ width: event[:rect][:width], height: event[:rect][:height] })
                             end
                             x = (@element[:offsetLeft].to_f || 0)
                             y = (@element[:offsetTop].to_f || 0)
                             width = event[:rect][:width]
                             height = event[:rect][:height]
                             # Translate when resizing from any corner
                             x += event[:deltaRect][:left].to_f
                             y += event[:deltaRect][:top].to_f

                             @original_atome.width (width if width.to_i.between?(min_width, max_width))
                             @original_atome.height (height if height.to_i.between?(min_height, max_height))

                             @original_atome.left(x)
                             @original_atome.top (y)
                             @element[:style][:left] = "#{x}px"
                             @element[:style][:top] = "#{y}px"

                           end
                         },

                       })
  end

  def over_over(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('mouseover') do
      bloc.call if bloc.is_a? Proc
    end
  end

  def over_false(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.unset
  end

  def overflow(params, bloc)
    style(:overflow, params)
    @overflow = @original_atome.instance_variable_get('@overflow_code')[:overflow]
    @element.addEventListener('scroll', lambda do |event|
      scroll_top = @element[:scrollTop].to_i
      scroll_left = @element[:scrollLeft].to_i
      @original_atome.instance_exec({ left: scroll_left, top: scroll_top }, &@overflow) if @overflow.is_a?(Proc)
    end)
  end

  def over_enter(bloc)
    JS.global[:myRubyMouseEnterCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseenter', function() { myRubyMouseEnterCallback(); });")
  end

  def over_leave(bloc)
    JS.global[:myRubyMouseLeaveCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseleave', function() { myRubyMouseLeaveCallback(); });")
  end

  def touch_tap
    interact = JS.eval("return interact('##{@id}')")
    @tap = @original_atome.instance_variable_get('@touch_code')[:tap]
    interact.on('tap') do |event|
      # bloc=@tap
      @original_atome.instance_exec(event, &@tap) if @tap.is_a?(Proc)
    end
  end

  def touch_double
    interact = JS.eval("return interact('##{@id}')")
    @touch_double = @original_atome.instance_variable_get('@touch_code')[:double]
    interact.on('doubletap') do |event|
      @original_atome.instance_exec(event, &@touch_double) if @touch_double.is_a?(Proc)
    end
  end

  def touch_long
    @touch_long = @original_atome.instance_variable_get('@touch_code')[:long]
    interact = JS.eval("return interact('##{@id}')")
    interact.on('hold') do |event|
      @original_atome.instance_exec(event, &@touch_long) if @touch_long.is_a?(Proc)
    end
  end

  def touch_down
    @touch_down = @original_atome.instance_variable_get('@touch_code')[:down]
    interact = JS.eval("return interact('##{@id}')")
    interact.on('down') do |event|
      @original_atome.instance_exec(event, &@touch_down) if @touch_down.is_a?(Proc)
    end
  end

  def touch_up
    @touch_up = @original_atome.instance_variable_get('@touch_code')[:up]
    interact = JS.eval("return interact('##{@id}')")
    interact.on('up') do |event|
      # alert "up : #{self}"
      @original_atome.instance_exec(event, &@touch_up) if @touch_up.is_a?(Proc)
    end
  end

  def touch_remove
    interact = JS.eval("return interact('##{@id}')")
    interact.unset
  end

  def filter_touch(item_to_remove) end

  def touch_remove_long
    # touch_remove
    # @original_atome.instance_variable_get('@touch_code')[:down] = @touch_down
    @original_atome.instance_variable_get('@touch_code')[:long]=''
    touch_long
  end
  def touch_remove_double
    # touch_remove
    # @original_atome.instance_variable_get('@touch_code')[:down] = @touch_down
    @original_atome.instance_variable_get('@touch_code')[:double]=''
    touch_double
  end
  def touch_remove_tap
    # touch_remove
    # @original_atome.instance_variable_get('@touch_code')[:down] = @touch_down
    @original_atome.instance_variable_get('@touch_code')[:tpa]=''
    touch_tap
  end
  def touch_remove_up
    # touch_remove
    # @original_atome.instance_variable_get('@touch_code')[:down] = @touch_down
    @original_atome.instance_variable_get('@touch_code')[:up]=''
    touch_up
  end
  def touch_remove_down
    # touch_remove
    # @original_atome.instance_variable_get('@touch_code')[:down] = @touch_down
    @original_atome.instance_variable_get('@touch_code')[:down]=''
    touch_down
  end

  def internet
    JS.eval('return navigator.onLine')
  end

  def terminal(id, cmd)
    if Atome.host == 'tauri'
      JS.eval("terminal('#{id}','#{cmd}')")
    else
      JS.eval("distant_terminal('#{id}','#{cmd}')")
    end
  end

  def read(id, file)
    if Atome.host == 'tauri'
      JS.eval("readFile('#{id}','#{file}')")
    else
      puts " work in progress"
    end
  end

  def browse(id, file)
    if Atome.host == 'tauri'
      JS.eval("browseFile('#{id}','#{file}')")
    else
      puts "work in progress"
    end
  end

  def handle_input
    @original_atome.instance_variable_set("@data", @element[:innerText].to_s)
  end

  # this method update the data content of the atome
  def update_data(params)
    # we update the @data of the atome
    @input_listener ||= lambda { |event| handle_input }
    if params
      @element.addEventListener('input', &@input_listener)
    else
      @element.removeEventListener('input', &@input_listener)
    end
  end

  # animation below
  def animate(animation_properties)
    command = <<~JS
          var target_div = document.getElementById('#{@id}');
          window.currentAnimation = popmotion.animate({
            from: #{animation_properties[:from]},
            to: #{animation_properties[:to]},
            duration: #{animation_properties[:duration]},
            onUpdate: function(v) {
      rubyVMCallback("puts x= "+v)
      rubyVMCallback("grab('#{@id}').left("+v+")")
            },
            onComplete: function() {
              window.currentAnimation = null;
      rubyVMCallback("puts :complete")
            }
          });
    JS
    JS.eval(command)
  end

  def play_animation(properties)
    required_keys = [:from, :to, :duration]
    if properties.is_a?(Hash) && (required_keys - properties.keys).empty?
      animate(properties)
    else
      raise ArgumentError, "Properties must be a hash with :from, :to, and :duration keys"
    end
  end

  def stop_animation
    JS.eval("if (window.currentAnimation) window.currentAnimation.stop();")
  end

  # def remove_event(bloc)
  #   interact = JS.eval("return interact('##{@id}')")
  #   interact.off('tap', &bloc)
  # end

end
