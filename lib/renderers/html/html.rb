class HTML
  def initialize(id_found, current_atome)
    @html_object ||= JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @atome = current_atome
    self
  end

  def attr(attribute, value)
    @html_object.setAttribute(attribute.to_s, value.to_s)
    self
  end

  def add_class(class_to_add)
    @html_object[:classList].add(class_to_add.to_s)
    self
  end

  def id(id)
    attr('id', id)
    self
  end

  def shape(id)
    markup_found = @atome.markup || :div
    @html_type = markup_found.to_s
    @html_object = JS.global[:document].createElement(@html_type)
    JS.global[:document][:body].appendChild(@html_object)
    add_class("atome")
    id(id)
    self
  end

  # def shape(id)
  #   @html_type = :div
  #   @html_object = JS.global[:document].createElement("div")
  #   JS.global[:document][:body].appendChild(@html_object)
  #   add_class("atome")
  #   id(id)
  #   self
  # end

  def text(id, markup = 'pre')
    @html_type = :div
    @html_object = JS.global[:document].createElement(markup.to_s)
    JS.global[:document][:body].appendChild(@html_object)
    add_class("atome")
    id(id)
    self
  end

  # def changeMarkup(new_markup)
  #   unless @atome.markup.to_s || new_markup.to_s
  #     alert new_markup
  #   end
  # end

  def innerText(data)
    @html_object[:innerText] = data.to_s
  end

  def textContent(data)
    @html_object[:textContent] = data
  end

  def style(property, value = nil)

    element_found = JS.global[:document].getElementById(@id.to_s)

    if value
      element_found[:style][property] = value.to_s
    else
      element_found[:style][property]
    end
    # self
    element_found[:style][property]
  end

  def filter= values
    property = values[0]
    value = values[1]
    `#{@html_object}.style.filter = #{property}+'('+#{value}+')'`
  end

  def append_to(parent_id_found)
    parent_found = JS.global[:document].getElementById(parent_id_found.to_s)
    parent_found.appendChild(@html_object)
    self
  end

  def append(child_id_found)
    child_found = JS.global[:document].getElementById(child_id_found.to_s)
    @html_object.appendChild(child_found)
    self
  end

  ###### event handler ######

  def event(action, options, bloc)
    # puts "bloc : #{bloc}"
    send("#{action}_#{options}", bloc)
  end


  def drag_move_true(bloc)
    interact = JS.eval("return interact('##{@id}')")

    interact.on('dragstart', lambda do |native_event|
      @atome.width(33)
      alert 'clone creation'
      @atome= box({id: "#{@id}_cloned"})

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
    ####################

  end



  def over_true(bloc)
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

  def touch_true(bloc)
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

  ###### end event handler ######

end