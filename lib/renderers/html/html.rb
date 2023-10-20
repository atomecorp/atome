# frozen_string_literal: true

class HTML
  def initialize(id_found, current_atome)
    @element ||= JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @atome = current_atome
    # @element = JS.global[:document].getElementById(@id.to_s)
  end

  def hypertext(params)
    current_div = JS.global[:document].getElementById(@id.to_s)
    current_div[:innerHTML] = params
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
    # alert html_object[:className].to_s.class
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

  def shape(id)
    markup_found = @atome.markup || :div
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def text(id)
    markup_found = @atome.markup || :pre
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def image(id)
    markup_found = @atome.markup || :img
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def video(id)
    markup_found = @atome.markup || :video
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def www(id)
    markup_found = @atome.markup || :iframe
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
    @element = JS.global[:document].createElement('div')
    add_class('atome')
    self.id(id)
    JS.global[:document][:body].appendChild(@element)
    self
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

  def innerText(data)
    @element[:innerText] = data.to_s
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
    @element[:style][property] = value.to_s
    if value
      @element[:style][property] = value.to_s
    else
      @element[:style][property]
    end
    @element[:style][property]
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

  def display(param)
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
    if property == 'resize'
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
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      else
        bloc.call(event) if bloc.is_a? Proc
      end
    end
    @element.addEventListener('keypress', keypress_handler)
  end

  def keyboard_keydown(bloc)
    keypress_handler = ->(event) do
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      else
        bloc.call(event) if bloc.is_a? Proc
      end
    end
    @element.addEventListener('keydown', keypress_handler)
  end

  def keyboard_keyup(bloc)
    keypress_handler = ->(event) do
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      else
        bloc.call(event) if bloc.is_a? Proc
      end
    end
    @element.addEventListener('keyup', keypress_handler)
  end

  def keyboard_kill(bloc)
    bloc.call if bloc.is_a? Proc
  end

  def keyboard_input(bloc)
    input_handler = ->(event) do
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      else
        if Native(event)[:target]
          input_content = Native(event)[:target][:textContent] # Obtenez le contenu textuel de l'élément <pre>
          bloc.call(input_content) if bloc.is_a? Proc
        end
      end

    end
    @element.addEventListener('input', input_handler)
  end

  def event(action, options, bloc)
    send("#{action}_#{options}", bloc)
  end

  def drag_false(val)
    interact = JS.eval("return interact('##{@id}')")
    interact.unset
  end

  def drag_start(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('dragstart', lambda do |_native_event|
      bloc.call if bloc.is_a? Proc
    end)
  end

  def drag_end(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('dragend', lambda do |_native_event|
      bloc.call if bloc.is_a? Proc
    end)
  end

  def drag_move(bloc)
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
      dx = event[:dx]
      dy = event[:dy]
      x = (@atome.left || 0) + dx.to_f
      y = (@atome.top || 0) + dy.to_f
      @atome.left(x)
      @atome.top(y)
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

  def resize(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.resizable({
                         edges: { left: true, right: true, top: true, bottom: true },
                         inertia: true,
                         modifiers: [],
                         listeners: {
                           move: lambda do |native_event|
                             event = Native(native_event)
                             bloc.call({ width: event[:rect][:width], height: event[:rect][:height] }) if bloc.instance_of? Proc
                             x = (@element[:offsetLeft].to_f || 0)
                             y = (@element[:offsetTop].to_f || 0)
                             width = event[:rect][:width]
                             height = event[:rect][:height]
                             # Translate when resizing from any corner
                             x += event[:deltaRect][:left].to_f
                             y += event[:deltaRect][:top].to_f

                             @element[:style][:left] = "#{x}px"
                             @element[:style][:top] = "#{y}px"
                             @element[:style][:width] = "#{width}px"
                             @element[:style][:height] = "#{height}px"
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

  def over_enter(bloc)
    JS.global[:myRubyMouseEnterCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseenter', function() { myRubyMouseEnterCallback(); });")
  end

  def over_leave(bloc)
    JS.global[:myRubyMouseLeaveCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseleave', function() { myRubyMouseLeaveCallback(); });")
  end

  def touch_tap(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('tap', bloc) do
      bloc.call if bloc.is_a? Proc
    end
  end

  def touch_false(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.unset
  end

  def touch_double(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('doubletap') do
      bloc.call if bloc.is_a? Proc
    end
  end

  def touch_long(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('hold') do
      bloc.call if bloc.is_a? Proc
    end
  end

  def touch_down(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('down') do
      bloc.call if bloc.is_a? Proc
    end
  end

  def touch_up(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('up') do
      bloc.call if bloc.is_a? Proc
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
      puts " work in progress"
      # JS.eval("readFile('#{id}','#{file}')")
    end
  end

  def browse(id, file)
    if Atome.host == 'tauri'
      JS.eval("browseFile('#{id}','#{file}')")
    else
      puts " work in progress"
      # JS.eval("readFile('#{id}','#{file}')")
    end
  end

  def handle_input(event)
    target = event[:target]
    inner_text = target[:innerText].to_s
    grab(@id).store(data: inner_text)
  end

  # this method update the data content of the atome
  def update_data(params)
    @input_listener ||= lambda { |event| handle_input(event) }
    if params
      @element.addEventListener('input', &@input_listener)
    else
      alert :stopped
      @element.removeEventListener('input', &@input_listener)
    end
  end


  # def handle_input(event)
  #   target = event[:target]
  #   inner_text = target[:innerText].to_s
  #    grab(@id).store(data: inner_text)
  # end
  #
  #
  #
  # def update_data(params)
  #   @element.addEventListener('input') do |event|
  #     handle_input(event)
  #   end
  # end

end


