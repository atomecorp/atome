class HTML
  def initialize(id_found, current_atome)
    @html ||= JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @atome = current_atome
    self
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
      puts "Width: #{width}, Height: #{height}"
    end

  end

  def style(property, value = nil)

    element_found = JS.global[:document].getElementById(@id.to_s)

    if value
      element_found[:style][property] = value.to_s
    else
      element_found[:style][property]
    end
    element_found[:style][property]
  end

  def filter= values
    property = values[0]
    value = values[1]
    `#{@html}.style.filter = #{property}+'('+#{value}+')'`
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

  def event(action, options, bloc)
    send("#{action}_#{options}", bloc)
  end

  def drag_start(val)
    puts 'drag start ok!!'
  end

  def drag_end(val)
    puts 'drag end ok!!'
  end

  def drag_drag(bloc)
    interact = JS.eval("return interact('##{@id}')")

    interact.on('dragstart', lambda do |native_event|
      @atome.width(33)
      alert 'clone creation'
      @atome = box({ id: "#{@id}_cloned" })

    end)

    interact.on('dragend', lambda do |native_event|
      @atome.width(333)
      alert 'unset drag'

      JS.eval(<<-JS)
  interact('##{@id}').unset()
      JS
    end)

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
      # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
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

  def over_over(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('mouseover') do
      bloc.call
    end
  end

  def over_enter(bloc)
    JS.global[:myRubyMouseEnterCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseenter', function() { myRubyMouseEnterCallback(); });")

  end

  def over_leave(bloc)
    JS.global[:myRubyMouseLeaveCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseleave', function() { myRubyMouseLeaveCallback(); });")
  end

  def touch_touch(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('tap') do
      bloc.call
    end
  end

  def touch_double(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('doubletap') do
      bloc.call
    end
  end

  def touch_long(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('hold') do
      bloc.call
    end
  end

  def touch_down(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('down') do
      bloc.call
    end
  end

  def touch_up(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('up') do
      bloc.call
    end
  end

end