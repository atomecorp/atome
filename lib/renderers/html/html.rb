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

    operator = conditions[:operator] == :and ? 'and' : 'or'

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
        if prop == 'background-color'
          data[:apply][key][:color] = value.to_sym
        elsif value[-2..] == 'px'
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
      next if line.empty? || line.start_with?('/*')

      if inside_media
        if line == '}'
          hash_result['@media'] << media_hash
          inside_media = false
          next
        end

        selector, properties = line.split('{').map(&:strip)
        next unless properties&.end_with?('}')

        properties = properties[0...-1].strip
        media_hash[selector] = extract_properties(properties)
      elsif line.start_with?('@media')
        media_content = line.match(/@media\s*\(([^)]+)\)\s*{/)
        next unless media_content

        media_query = media_content[1]
        hash_result['@media'] = [media_query]
        inside_media = true
      else
        selector, properties = line.split('{').map(&:strip)
        next unless properties&.end_with?('}')

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

  def remove_class(class_to_remove)
    @element[:classList].remove(class_to_remove.to_s)
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
    ####

    # editable_pres = JS.global[:document].querySelectorAll('pre[contenteditable="true"]')
    # editable_pres_array = Array.new(editable_pres[:length].to_i) { |i| editable_pres.call(:item, i) }
    # editable_pres_array.each do |pre|
    #   pre.addEventListener('input') do
    #     if pre[:innerText].strip == ''
    #       pre[:innerHTML] = '&#8203;' # Insère un caractère d'espace insécable
    #     end
    #   end
    # end

    # editable_pres = JS.global[:document].querySelectorAll('pre[contenteditable="true"]')
    #
    # editable_pres_array = Array.new(editable_pres[:length].to_i) { |i| editable_pres.call(:item, i) }
    # editable_pres_array.each do |pre|
    #   pre.addEventListener('click') do
    #     # Focus sur l'élément pour activer le curseur
    #     pre.focus()
    #     alert :ok
    #     # Optionnel : Ajoutez du style pour rendre le curseur plus visible
    #     pre[:style][:caretColor] = 'blue' # Changez la couleur du curseur en bleu
    #   end
    # end
    ###
    self
  end

  def select_text(range)
    # TODO : use atome color object  instead of basic css color
    back_color = grab(:back_selection)
    text_color = grab(:text_selection)

    back_color_rgba = "rgba(#{back_color.red * 255},#{back_color.green * 255},#{back_color.blue * 255}, #{back_color.alpha})"
    text_color_rgba = "rgba(#{text_color.red * 255},#{text_color.green * 255},#{text_color.blue * 255}, #{text_color.alpha})"

    range = JS.global[:document].createRange()
    range.selectNodeContents(@element)
    selection = JS.global[:window].getSelection()
    selection.removeAllRanges()
    selection.addRange(range)
    @element.focus()
    style = JS.global[:document].createElement('style')
    style[:innerHTML] = "::selection { background-color: #{back_color_rgba}; color: #{text_color_rgba}; }"
    JS.global[:document][:head].appendChild(style)
    return unless @element[:innerText].to_s.length == 1

    @element[:innerHTML] = '&#8203;'
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
    svg_ns = 'http://www.w3.org/2000/svg'
    @element = JS.global[:document].createElementNS(svg_ns, 'svg')
    JS.global[:document][:body].appendChild(@element)
    @element.setAttribute('viewBox', '0 0 1024 1024')
    @element.setAttribute('version', '1.1')
    add_class('atome')
    self.id(id)
    self
  end

  def svg_data(data)
    data.each do |type_passed, datas|
      svg_ns = 'http://www.w3.org/2000/svg'
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
        .gsub('&', "\&")
        .gsub('<', "\<")
        .gsub('>', "\>")
        .gsub('"', '"')
        .gsub("'", "\'")
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

  def backdropFilter(property, value)
    filter_needed = "#{property}(#{value})"
    @element[:style][:"-webkit-backdrop-filter"] = filter_needed
  end

  def currentTime(time)
    @element[:currentTime] = time
  end

  def animation_frame_callback(proc_pass, play_content)
    JS.global[:window].requestAnimationFrame(-> (timestamp) {
      current_time = @element[:currentTime]
      fps = 30
      current_frame = (current_time.to_f * fps).to_i
      @original_atome.instance_exec({ frame: current_frame, time: current_time }, &proc_pass) if proc_pass.is_a? Proc
      # we update play instance variable so if user ask for atome.play it will return current frame
      play_content[:play] = current_frame
      animation_frame_callback(proc_pass, play_content)
    })
  end

  def action(_particle, action_found, option = nil)

    # alert option
    if action_found == :stop
      currentTime(option)
      @element.pause
    elsif action_found == :pause
      @element.pause
    else
      currentTime(option)
      proc_found = @original_atome.instance_variable_get('@play_code')[action_found]
      play_content = @original_atome.instance_variable_get('@play')
      animation_frame_callback(proc_found, play_content)
      @element.play
    end
  end

  def append_to(parent_id_found)
    parent_found = JS.global[:document].getElementById(parent_id_found.to_s)
    parent_found.appendChild(@element)
    self
  end

  # def visible(param)
  #   @element[:style][:display] = param.to_s
  # end

  def delete(id_to_delete)
    element_to_delete = JS.global[:document].getElementById(id_to_delete.to_s)
    element_to_delete.remove if element_to_delete
  end

  def append(child_id_found)
    child_found = JS.global[:document].getElementById(child_id_found.to_s)
    @element.appendChild(child_found)
    self
  end

  # events handlers
  def on(property, _option)
    bloc = @original_atome.instance_variable_get('@on_code')[:view_resize]
    property = property.to_s

    if property.start_with?('media:')
      # extract request from property
      media_query = property.split(':', 2).last

      mql = JS.global[:window].matchMedia(media_query)

      event_handler = ->(event) do
        bloc.call({ matches: event[:matches] }) if bloc.is_a? Proc
      end

      # add a listener to matchMedia object
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

  def keyboard_press(_option)
    @keyboard_press = @original_atome.instance_variable_get('@keyboard_code')[:press]

    keypress_handler = ->(native_event) do

      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @keyboard_press.call(event) if @keyboard_press.is_a?(Proc)
    end
    @element.addEventListener('keypress', keypress_handler)
  end

  def keyboard_down(_option)
    @keyboard_down = @original_atome.instance_variable_get('@keyboard_code')[:down]

    keypress_handler = ->(event) do
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @keyboard_down.call(event) if @keyboard_down.is_a?(Proc)
    end
    @element.addEventListener('keydown', keypress_handler)
  end

  def keyboard_up(_option)
    @keyboard_up = @original_atome.instance_variable_get('@keyboard_code')[:up]

    keypress_handler = ->(event) do
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @keyboard_up.call(event) if @keyboard_up.is_a?(Proc)
    end
    @element.addEventListener('keyup', keypress_handler)
  end

  def keyboard_remove(option)
    case option
    when :down
      @keyboard_down = ''
    when :up
      @keyboard_up = ''
    when :down
      @keyboard_press = ''
    else
      @keyboard_down = ''
      @keyboard_up = ''
      @keyboard_press = ''
    end
  end

  def event(action, variance, option = nil)
    send("#{action}_#{variance}", option)
  end

  def restrict_movement(restricted_x, restricted_y)
    @original_atome.left(restricted_x)
    @original_atome.top(restricted_y)
  end

  def drag_remove(option)
    case option
    when :start
      @drag_start = ''
    when :end, :stop
      @drag_end = ''
    when :locked
      @drag_locked = ''
    when :restrict
      @drag_restrict = ''
    else
      # to remove all interact event ( touch, drag, scale, ... uncomment below)
      @drag_start = ''
      @drag_end = ''
      @drag_locked = ''
      @drag_restrict = ''
    end

  end

  def drag_start(_option)
    interact = JS.eval("return interact('##{@id}')")
    @drag_start = @original_atome.instance_variable_get('@drag_code')[:start]
    interact.on('dragstart') do |native_event|
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @drag_start.call(event) if @drag_start.is_a?(Proc)
    end
  end

  def drag_end(_option)
    interact = JS.eval("return interact('##{@id}')")
    @drag_end = @original_atome.instance_variable_get('@drag_code')[:end]
    interact.on('dragend') do |native_event|
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @drag_end.call(event) if @drag_end.is_a?(Proc)
    end
  end

  def drag_move(_option)
    interact = JS.eval("return interact('##{@id}')")
    interact.draggable({
                         drag: true,
                         inertia: { resistance: 12,
                                    minSpeed: 200,
                                    endSpeed: 100 },
                       })

    @drag_move = @original_atome.instance_variable_get('@drag_code')[:move]
    interact.on('dragmove') do |native_event|
      # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @drag_move.call(event) if @drag_move.is_a?(Proc)

      dx = event[:dx]
      dy = event[:dy]
      x = (@original_atome.left || 0) + dx.to_f
      y = (@original_atome.top || 0) + dy.to_f
      @original_atome.left(x)
      @original_atome.top(y)
    end
  end

  def drag_restrict(option)
    interact = JS.eval("return interact('##{@id}')")
    interact.draggable({
                         drag: true,
                         inertia: { resistance: 12,
                                    minSpeed: 200,
                                    endSpeed: 100 },
                       })

    @drag_move = @original_atome.instance_variable_get('@drag_code')[:restrict]
    if option.instance_of? Hash
      max_left = grab(:view).to_px(:width)
      max_top = grab(:view).to_px(:height)
      min_left = 0
      min_top = 0

      if option[:max]
        max_left = option[:max][:left] || max_left
        max_top = option[:max][:top] || max_top
      else
        max_left
        max_top
      end
      if option[:min]
        min_left = option[:min][:left] || min_left
        min_top = option[:min][:top] || min_top
      else
        min_left
        min_top
      end
    else
      parent_found = grab(option)
      min_left = parent_found.left
      min_top = parent_found.top
      parent_width = parent_found.width
      parent_height = parent_found.height
      original_width = @original_atome.width
      original_height = @original_atome.height
      max_left = min_left + parent_width - original_width
      max_top = min_top + parent_height - original_height
    end

    interact.on('dragmove') do |native_event|
      # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @drag_move.call(event) if @drag_move.is_a?(Proc)
      dx = event[:dx]
      dy = event[:dy]
      x = (@original_atome.left || 0) + dx.to_f
      y = (@original_atome.top || 0) + dy.to_f
      restricted_x = [[x, min_left].max, max_left].min
      restricted_y = [[y, min_top].max, max_top].min
      restrict_movement(restricted_x, restricted_y)
    end
  end

  def drag_locked(_option)
    interact = JS.eval("return interact('##{@id}')")
    interact.draggable({
                         drag: true,
                         inertia: { resistance: 12,
                                    minSpeed: 200,
                                    endSpeed: 100 }
                       })

    @drag_lock = @original_atome.instance_variable_get('@drag_code')[:locked]
    interact.on('dragmove') do |native_event|
      # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @drag_lock.call(event) if @drag_lock.is_a?(Proc)
    end
  end

  def drop_action(native_event, bloc)
    event = Native(native_event)
    draggable_element = event[:relatedTarget][:id].to_s
    dropzone_element = event[:target][:id].to_s
    # we use .call instead of instance_eval because instance_eval bring the current object as context
    # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
    # group etc..
    bloc.call({ source: draggable_element, destination: dropzone_element }) if bloc.is_a?(Proc)
  end

  def drop_activate(_option)
    interact = JS.eval("return interact('##{@id}')")
    @drop_activate = @original_atome.instance_variable_get('@drop_code')[:activate]

    interact.dropzone({
                        accept: nil, # Accept any element
                        overlap: 0.75,
                        ondropactivate: lambda do |native_event|
                          drop_action(native_event, @drop_activate)
                        end
                      })
  end

  def drop_deactivate(_option)
    interact = JS.eval("return interact('##{@id}')")
    @drop_deactivate = @original_atome.instance_variable_get('@drop_code')[:deactivate]
    interact.dropzone({
                        # accept: nil, # Accept any element
                        # overlap: 0.75,
                        # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                        ondropdeactivate: lambda do |native_event|
                          drop_action(native_event, @drop_deactivate)
                        end
                      })
  end

  def drop_dropped(_option)
    @drop_dropped = @original_atome.instance_variable_get('@drop_code')[:dropped]
    interact = JS.eval("return interact('##{@id}')")
    interact.dropzone({
                        # accept: nil, # Accept any element
                        overlap: 0.75,
                        # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                        ondrop: lambda do |native_event|
                          drop_action(native_event, @drop_dropped)
                        end
                      })
  end

  def drop_enter(_option)
    interact = JS.eval("return interact('##{@id}')")

    @drop_enter = @original_atome.instance_variable_get('@drop_code')[:enter]

    interact.dropzone({
                        # accept: nil,
                        overlap: 0.001,
                        # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                        ondragenter: lambda do |native_event|
                          drop_action(native_event, @drop_enter)
                        end
                      })
  end

  def drop_leave(_option)
    interact = JS.eval("return interact('##{@id}')")
    @drop_leave = @original_atome.instance_variable_get('@drop_code')[:leave]

    interact.dropzone({
                        # accept: nil,
                        # overlap: 0.75,
                        # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                        ondragleave: lambda do |native_event|
                          drop_action(native_event, @drop_leave)
                        end
                      })

  end

  def drop_remove(option)
    case option
    when :activate
      @drop_activate = ''
    when :deactivate
      @drop_deactivate = ''
    when :dropped
      @drop_dropped = ''
    when :enter
      @drop_enter = ''
    when :leave
      @drop_leave = ''
    else
      # to remove all interact event ( touch, drag, scale, ... uncomment below)
      # interact = JS.eval("return interact('##{@id}')")
      # interact.unset
      @drop_activate = ''
      @drop_deactivate = ''
      @drop_dropped = ''
      @drop_enter = ''
      @drop_leave = ''

    end

  end

  def resize(params, options)
    interact = JS.eval("return interact('##{@id}')")
    if params == :remove
      @resize = ''
      interact.resizable(false)
    else
      min_width = options[:min][:width] || 10
      min_height = options[:min][:height] || 10
      max_width = options[:max][:width] || 3000
      max_height = options[:max][:height] || 3000
      @resize = @original_atome.instance_variable_get('@resize_code')[:resize]
      interact.resizable({
                           edges: { left: true, right: true, top: true, bottom: true },
                           inertia: true,
                           modifiers: [],
                           listeners: {
                             move: lambda do |native_event|
                               if @resize.is_a?(Proc)
                                 event = Native(native_event)
                                 # we use .call instead of instance_eval because instance_eval bring the current object as context
                                 # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
                                 # group etc..
                                 @resize.call(event) if @resize.is_a?(Proc)
                                 x = (@element[:offsetLeft].to_i || 0)
                                 y = (@element[:offsetTop].to_i || 0)
                                 width = event[:rect][:width]
                                 height = event[:rect][:height]
                                 # Translate when resizing from any corner
                                 x += event[:deltaRect][:left].to_f
                                 y += event[:deltaRect][:top].to_f
                                 @original_atome.width width.to_i if width.to_i.between?(min_width, max_width)
                                 @original_atome.height height.to_i if height.to_i.between?(min_height, max_height)
                                 @original_atome.left(x)
                                 @original_atome.top (y)
                               end
                             end
                           },

                         })
    end

  end

  def overflow(params, bloc)
    style(:overflow, params)
    @overflow = @original_atome.instance_variable_get('@overflow_code')[:overflow]
    @element.addEventListener('scroll', lambda do |event|
      scroll_top = @element[:scrollTop].to_i
      scroll_left = @element[:scrollLeft].to_i
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @overflow.call({ left: scroll_left, top: scroll_top }) if @overflow.is_a?(Proc)
    end)
  end

  def over_over(_option)
    interact = JS.eval("return interact('##{@id}')")
    @over_over = @original_atome.over_code[:over]
    interact.on('mouseover') do |native_event|
      JS.global[:myRubyMouseOverCallback] = Proc.new { @original_atome.over_code[:over].call }
      JS.eval("document.querySelector('##{@id}').addEventListener('mouseleave', myRubyMouseOverCallback);")
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @over_over.call(event) if @over_over.is_a?(Proc)
    end
  end

  def over_enter(_option)
    @over_enter = @original_atome.instance_variable_get('@over_code')[:enter]
    return unless @over_enter

    @over_enter_callback = lambda do |event|
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @over_enter.call(event) if @over_enter.is_a?(Proc)
    end
    @element.addEventListener('mouseenter', @over_enter_callback)

  end

  def over_leave(_option)
    @over_leave = @original_atome.instance_variable_get('@over_code')[:leave]
    return unless @over_leave

    @over_leave_callback = lambda do |event|
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @over_leave.call(event) if @over_leave.is_a?(Proc)
    end
    @element.addEventListener('mouseleave', @over_leave_callback)

  end

  def over_remove(option)
    case option
    when :enter
      if @over_enter_callback
        # Remove the event listener using the same lambda
        @element.removeEventListener('mouseenter', @over_enter_callback)
        @over_enter_callback = nil
        @over_enter = nil
      end
    when :leave
      @element.removeEventListener('mouseleave', @over_leave_callback)
      @over_leave_callback = nil
      @over_leave = nil
    when :over
      @over_over = ''
    else
      @element.removeEventListener('mouseenter', @over_enter_callback)
      @over_enter_callback = nil
      @over_enter = nil
      @element.removeEventListener('mouseleave', @over_leave_callback)
      @over_leave_callback = nil
      @over_leave = nil
      @over_over = ''
    end
  end

  def touch_tap(_option)
    interact = JS.eval("return interact('##{@id}')")
    @touch_tap = @original_atome.instance_variable_get('@touch_code')[:tap]
    interact.on('tap') do |native_event|
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @touch_tap.call(event) if @touch_tap.is_a?(Proc)
    end
  end

  def touch_double(_option)
    interact = JS.eval("return interact('##{@id}')")
    @touch_double = @original_atome.instance_variable_get('@touch_code')[:double]
    interact.on('doubletap') do |native_event|
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @touch_double.call(event) if @touch_double.is_a?(Proc)
    end
  end

  def touch_long(_option)
    @touch_long = @original_atome.instance_variable_get('@touch_code')[:long]
    interact = JS.eval("return interact('##{@id}')")
    interact.on('hold') do |native_event|
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @touch_long.call(event) if @touch_long.is_a?(Proc)
    end
  end

  def touch_down(_option)
    @touch_down = @original_atome.instance_variable_get('@touch_code')[:down]
    interact = JS.eval("return interact('##{@id}')")
    interact.on('down') do |native_event|
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @touch_down.call(event) if @touch_down.is_a?(Proc)
    end
  end

  def touch_up(_option)
    @touch_up = @original_atome.instance_variable_get('@touch_code')[:up]
    interact = JS.eval("return interact('##{@id}')")
    interact.on('up') do |native_event|
      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @touch_up.call(event) if @touch_up.is_a?(Proc)
    end
  end

  def touch_remove(option)
    case option
    when :double
      @touch_double = ''
    when :down
      @touch_down = ''
    when :long
      @touch_long = ''
    when :tap
      @touch_tap = ''
    when :up
      @touch_up = ''
    else
      @touch_double = ''
      @touch_down = ''
      @touch_long = ''
      @touch_tap = ''
      @touch_up = ''
      # to remove all interact event ( touch, drag, scale, ... uncomment below)
      # interact = JS.eval("return interact('##{@id}')")
      # interact.unset
    end

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
      puts ' work in progress'
    end
  end

  def browse(id, file)
    if Atome.host == 'tauri'
      JS.eval("browseFile('#{id}','#{file}')")
    else
      puts 'work in progress'
    end
  end

  def handle_input
    @original_atome.instance_variable_set('@data', @element[:innerText].to_s)
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
    puts 'change for standard method : action'
    required_keys = [:from, :to, :duration]
    unless properties.is_a?(Hash) && (required_keys - properties.keys).empty?
      raise ArgumentError, 'Properties must be a hash with :from, :to, and :duration keys'
    end

    animate(properties)

  end

  def stop_animation
    JS.eval('if (window.currentAnimation) window.currentAnimation.stop();')
  end

  # Table manipulation

  def table(data)
    table_html = JS.global[:document].createElement('table')
    thead = JS.global[:document].createElement('thead')

    max_length = data.max_by { |row| row.keys.length }.keys.length

    if @original_atome.option[:header]
      header_row = JS.global[:document].createElement('tr')

      max_length.times do |i|
        th = JS.global[:document].createElement('th')
        th[:textContent] = data.map { |row| row.keys[i].to_s }.compact.first || ''
        header_row.appendChild(th)
      end

      thead.appendChild(header_row)
    end

    table_html.appendChild(thead)
    tbody = JS.global[:document].createElement('tbody')

    data.each_with_index do |row, row_index|
      tr = JS.global[:document].createElement('tr')

      max_length.times do |cell_index|
        td = JS.global[:document].createElement('td')
        cell_size = set_td_style(td)
        cell_height = cell_size[:cell_height]

        cell_value = row.values[cell_index]
        if cell_value.instance_of? Atome
          cell_value.fit(cell_height)
          html_element = JS.global[:document].getElementById(cell_value.id.to_s)
          td.appendChild(html_element)
          html_element[:style][:transformOrigin] = 'top left'
          html_element[:style][:position] = 'relative'
          cell_value.top(0)
          cell_value.left(0)
        else
          td[:textContent] = cell_value.to_s
        end
        tr.appendChild(td)
      end

      tbody.appendChild(tr)
    end
    table_html.appendChild(tbody)
    JS.global[:document].querySelector("##{@id}").appendChild(table_html)
  end

  def refresh_table(_params)
    # first we need to extact all atome from the table or they will be deleted by the table refres
    data = @original_atome.data
    data.each do |row|
      row.each do |k, v|
        if v.instance_of? Atome
          v.attach(:view)
        end
      end
    end
    table_element = JS.global[:document].querySelector("##{@id} table")
    if table_element.nil?
      puts 'Table not found'
      return
    end
    (table_element[:rows].to_a.length - 1).downto(1) do |i|
      table_element.deleteRow(i)
    end

    max_cells = data.map { |row| row.keys.length }.max

    data.each do |row|
      new_row = table_element.insertRow(-1)
      max_cells.times do |i|
        key = row.keys[i]
        value = row[key]
        cell = new_row.insertCell(-1)
        if value.instance_of? Atome
          html_element = JS.global[:document].getElementById(value.id.to_s)
          cell.appendChild(html_element)
        else
          cell[:textContent] = value.to_s
        end
        set_td_style(cell)
      end
    end
  end
  def set_td_style(td)
    cell_height = 50
    td[:style][:border] = '1px solid black'
    td[:style][:backgroundColor] = 'white'
    td[:style][:boxShadow] = '10px 10px 5px #888888'
    td[:style][:width] = "#{cell_height}px"
    td[:style]['min-width'] = "#{cell_height}px"
    td[:style]['max-width'] = "#{cell_height}px"
    td[:style]['min-height'] = "#{cell_height}px"
    td[:style]['max-height'] = "#{cell_height}px"
    td[:style][:height] = "#{cell_height}px"
    td[:style][:overflow] = 'hidden'
    { cell_height: cell_height, cell_width: cell_height }
  end


  def insert_cell(params)
    row_index, cell_index = params[:cell]
    new_content = params[:content]
    container = JS.global[:document].getElementById(@id.to_s)

    table = container.querySelector('table')
    if table.nil?
      puts 'No table found in the container'
      return
    end

    row = table.querySelectorAll('tr')[row_index]
    if row.nil?
      puts "Row at index #{row_index} not found"
      return
    end

    cell = row.querySelectorAll('td')[cell_index]
    if cell.nil?
      puts "Cell at index #{cell_index} in row #{row_index} not found"
      return
    end

    if new_content.instance_of? Atome
      cell.innerHTML = ''
      html_element = JS.global[:document].getElementById(new_content.id.to_s)
      cell.appendChild(html_element)
    else
      cell[:textContent] = new_content.to_s
    end
  end

  def insert_row(params)
    insert_at_index = params[:row]
    table_element = JS.global[:document].querySelector("##{@id} table")

    if table_element.nil?
      puts 'Tableau non trouvé'
      return
    end

    tbody = table_element.querySelector('tbody')

    header_row = table_element.querySelector('thead tr')
    column_count = header_row ? header_row.querySelectorAll('th').to_a.length : 0

    new_row = JS.global[:document].createElement('tr')
    column_count.times do |cell_index|
      td = JS.global[:document].createElement('td')
      set_td_style(td)
      new_row.appendChild(td)
    end

    if insert_at_index.zero?
      tbody.insertBefore(new_row, tbody.firstChild)
    else
      reference_row = tbody.querySelectorAll('tr').to_a[insert_at_index]
      tbody.insertBefore(new_row, reference_row)
    end

  end

  def insert_column(params)
    insert_at_index = params[:column]
    table_element = JS.global[:document].querySelector("##{@id} table")
    if table_element.nil?
      puts 'Table not found'
      return
    end
    rows = table_element.querySelectorAll('tr').to_a
    rows.each_with_index do |row, index|
      if index == 0
        # case1
      else
        new_cell = JS.global[:document].createElement('td')
        new_cell[:innerText] = ''
        set_td_style(new_cell)
        if insert_at_index.zero?
          row.insertBefore(new_cell, row.firstChild)
        else
          child_nodes = row.querySelectorAll('td').to_a

          if insert_at_index < child_nodes.length
            reference_cell = child_nodes[insert_at_index]
            row.insertBefore(new_cell, reference_cell)
          else
            row.appendChild(new_cell)
          end
        end
      end

    end

  end

  def table_insert(params)
    if params[:cell]
      insert_cell(params)
    elsif params[:row]
      insert_row(params)
    elsif params[:column]
      insert_column(params)
    end

  end


  def table_remove(params)
    if params[:row]
      row_index = params[:row]
      table_element = JS.global[:document].querySelector("##{@id} table")

      if table_element.nil?
        puts 'Table not found'
        return
      end

      rows = table_element.querySelectorAll('tbody tr').to_a

      if row_index >= rows.length
        puts "row not found : #{row_index}"
        return
      end
      row_to_remove = rows[row_index]

      row_to_remove[:parentNode].removeChild(row_to_remove)

      rows.each_with_index do |row, i|
        next if i <= row_index
      end
    elsif params[:column]
      column_index = params[:column]
      table_element = JS.global[:document].querySelector("##{@id} table")

      if table_element.nil?
        puts 'Table not found'
        return
      end

      rows = table_element.querySelectorAll('tbody tr').to_a
      rows.each do |row|
        cells = row.querySelectorAll('td').to_a
        if column_index < cells.length
          cell_to_remove = cells[column_index]
          cell_to_remove[:parentNode].removeChild(cell_to_remove)
        end
      end

    end
  end
  # atomisation


  def atomized(html_object)
    @element = html_object

    # @element.setAttribute('id', @id.to_s)
  end
end


