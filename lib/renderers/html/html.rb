# frozen_string_literal: true

class HTML
  def initialize(id_found, current_atome)
    @html ||= JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @atome = current_atome
    @element = JS.global[:document].getElementById(@id.to_s)
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
    @html.setAttribute(attribute.to_s, value.to_s)
    self
  end

  def add_class(class_to_add)
    @html[:classList].add(class_to_add.to_s)
    self
  end

  def id(id)
    attr('id', id)
    self
  end

  def shape(id)
    markup_found = @atome.markup || :div
    @html_type = markup_found.to_s
    @html = JS.global[:document].createElement(@html_type)
    JS.global[:document][:body].appendChild(@html)
    add_class("atome")
    id(id)
    self
  end

  def text(id)
    markup_found = @atome.markup || :pre
    @html_type = markup_found.to_s
    @html = JS.global[:document].createElement(@html_type)
    JS.global[:document][:body].appendChild(@html)
    add_class("atome")
    id(id)
    self
  end

  def image(id)
    markup_found = @atome.markup || :img
    @html_type = markup_found.to_s
    @html = JS.global[:document].createElement(@html_type)
    JS.global[:document][:body].appendChild(@html)
    add_class("atome")
    self.id(id)
    self
  end

  def video(id)
    markup_found = @atome.markup || :video
    @html_type = markup_found.to_s
    @html = JS.global[:document].createElement(@html_type)
    JS.global[:document][:body].appendChild(@html)
    add_class("atome")
    self.id(id)
    self
  end

  def www(id)
    markup_found = @atome.markup || :iframe
    @html_type = markup_found.to_s
    @html = JS.global[:document].createElement(@html_type)
    JS.global[:document][:body].appendChild(@html)
    add_class("atome")

    @html.setAttribute('src', "https://www.youtube.com/embed/lLeQZ8Llkso?si=MMsGBEXELy9yBl9R")
    # below we get image to feed width and height if needed
    # image = JS.global[:Image].new

    self.id(id)
    self
  end

  def raw(id)
    @html = JS.global[:document].createElement('div')
    add_class("atome")
    self.id(id)
    JS.global[:document][:body].appendChild(@html)
    self
  end

  def raw_data(html_string)
    @html[:innerHTML] = html_string
  end

  def video_path(video_path, type = 'video/mp4')
    source = JS.global[:document].createElement('source')
    source.setAttribute('src', video_path)
    source.setAttribute('type', type)
    @html.appendChild(source)
  end

  def innerText(data)
    @html[:innerText] = data.to_s
  end

  def textContent(data)
    @html[:textContent] = data
  end

  def path(objet_path)
    @html.setAttribute('src', objet_path)
    # below we get image to feed width and height if needed
    # image = JS.global[:Image].new
    @html[:src] = objet_path
    @html[:onload] = lambda do |_event|
      width = @html[:width]
      height = @html[:height]
      # puts "Width: #{width}, Height: #{height}"
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
    parent_found.appendChild(@html)
    self
  end

  def delete(id_to_delete)
    element_to_delete = JS.global[:document].getElementById(id_to_delete.to_s)
    element_to_delete.remove if element_to_delete
  end

  def append(child_id_found)
    child_found = JS.global[:document].getElementById(child_id_found.to_s)
    @html.appendChild(child_found)
    self
  end

  ###### event handler ######

  def keyboard_keypress(bloc)

    # element = JS.global[:document].getElementById(@id.to_s)
    keypress_handler = ->(event) do
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      else
        bloc.call(event) if bloc.is_a? Proc
      end
    end
    @element.addEventListener("keypress", keypress_handler)
  end

  def keyboard_keydown(bloc)

    # element = JS.global[:document].getElementById(@id.to_s)
    keypress_handler = ->(event) do
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      else
        bloc.call(event) if bloc.is_a? Proc
      end
    end
    @element.addEventListener("keydown", keypress_handler)
  end

  def keyboard_keyup(bloc)
    # element = JS.global[:document].getElementById(@id.to_s)
    keypress_handler = ->(event) do
      if grab(@id).keyboard[:kill] == true
        Native(event).preventDefault()
      else
        bloc.call(event) if bloc.is_a? Proc
      end
    end
    @element.addEventListener("keyup", keypress_handler)
  end

  def keyboard_kill(bloc)
    bloc.call if bloc.is_a? Proc
  end

  def keyboard_input(bloc)
    # element = JS.global[:document].getElementById(@id.to_s)
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
    @element.addEventListener("input", input_handler)
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
    JS.eval("return navigator.onLine")
  end

end
