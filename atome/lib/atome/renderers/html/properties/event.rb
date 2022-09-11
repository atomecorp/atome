module PropertyHtml

  def touch_html(value)
    if value.instance_of?(Array)
      # jq_get(atome_id).unbind("touchstart mousedown touchend mouseup")
      # jq_get(atome_id).off('click')
      value.each do |val|
        touch_html_helper(val)
      end
    else
      # jq_get(atome_id).unbind("touchstart mousedown touchend mouseup")
      # jq_get(atome_id).off('click')
      touch_html_helper(value)
    end
  end

  def drag_html(value)
    jq_object = jq_get(atome_id)
    value = {} if value == true
    if value == :destroy || value[:option] == :destroy
      # we initiate the scale first so it won't break if scale is destroy twice,
      # else : destroy scale then clear view will crash
      # jq_object.draggable(:destroy)
      `
if ($('#'+#{atome_id}).data('ui-draggable')) { // error to call destroy if not there
   $('#'+#{atome_id}).draggable('destroy');
}
`
    elsif value == :disable || value[:option] == :disable
      # we initiate the scale first so it won't break if scale is diasble twice,
      # else : destroy scale then clear view will crash
      jq_object.draggable(:disable)
    else
      grid = {}
      grid = { grid: [value[:grid][:x], value[:grid][:y]] } if value[:grid]
      containment = {}
      if value[:containment]
        case value[:containment]
        when :view
          containment = { containment: "document" }
        when Hash
          default = { x: 96, xx: 96, y: 96, yy: 96 }
          params = default.merge(value[:containment])
          containment = { containment: [params[:x], params[:y], params[:xx], params[:yy]] }
        else
          containment = { containment: "parent" }
        end
      end
      lock = case value[:lock]
             when :x
               { axis: "y" }
             when :y
               { axis: "x" }
             else
               {}
             end
      handle = if value[:handle]
                 { handle: "#" + value[:handle] }
               else
                 {}
               end
      fixed = {}
      fixed = { opacity: 0.0000000000000001, helper: :clone } if value[:fixed]

      options = lock.merge(handle).merge(containment).merge(grid).merge(fixed).merge({ multiple: true })
      jq_object.draggable(options)
      x_position_start = 0
      y_position_start = 0
      offset_x = 0
      offset_y = 0
      proc = value[:proc]

      jq_object.on(:dragstart) do |evt|
        evt.start = true
        # evt.stop = false
        evt.end = false
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        jq_get(atome_id).css("left", "#{x}px")
        jq_get(atome_id).css("right", "auto")
        jq_get(atome_id).css("top", "#{y}px")
        jq_get(atome_id).css("bottom", "auto")
        x_position_start = evt.page_x
        y_position_start = evt.page_y
        instance_exec evt, &proc if proc.is_a?(Proc)
        # value[:proc].call(evt) if value[:proc].is_a?(Proc)
      end

      jq_object.on(:dragstop) do |evt|
        drag[:drag] = true
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        evt.start = false
        # evt.stop = true
        evt.end =true
        # alert evt.methods
        # alert evt.start
        instance_exec evt, &proc if proc.is_a?(Proc)
        change_position_origin
        # value[:proc].call(evt) if value[:proc].is_a?(Proc)
      end

      jq_object.on(:drag) do |evt|

        drag[:drag] = :moving
        # evt.start = false
        # evt.stop = false
        offset_x = evt.page_x - x_position_start
        offset_y = evt.page_y - y_position_start
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        # we send the position to the proc
        instance_exec evt, &proc if proc.is_a?(Proc)
        # value[:proc].call(evt) if value[:proc].is_a?(Proc)
        # we update the position of the atome
        update_position
      end


    end

  end

  def key_html(value)
    options = value[:options]
    # the lines below is important for the object to get focus if not keypress wont be triggered
    atome = grab(atome_id)
    atome.edit(true)
    case options
    when :down
      jq_get(atome_id).on("keydown") do |evt|
        value[:proc].call(evt) if value[:proc].is_a?(Proc)
        evt.prevent_default unless self.type == :text || self.type == :particle
      end
    when :up
      jq_get(atome_id).on("keyup") do |evt|
        value[:proc].call(evt) if value[:proc].is_a?(Proc)
        evt.prevent_default unless self.type == :text || self.type == :particle
      end
    when :stop
      jq_get(atome_id).unbind("keypress")
      jq_get(atome_id).unbind("keydown")
      jq_get(atome_id).unbind("keyup")
      atome.edit(false)
    else
      jq_get(atome_id).on(:keypress) do |evt|
        evt.prevent_default unless self.type == :text || self.type == :particle
        value[:proc].call(evt) if value[:proc].is_a?(Proc)
      end
    end
  end

  def scale_html(value)
    default = { option: { handles: 'all' } }
    value = { option: value } unless value.instance_of?(Hash)
    value = default.merge(value)
    option = value[:option]
    option = option.merge(aspectRatio: true) if value[:ratio]
    option = option.merge(maxHeight: value[:height][:max]) if value[:height]
    option = option.merge(maxWidth: value[:width][:max]) if value[:width]
    option = option.merge(alsoResize: "##{value[:add].to_s}") if value[:add]
    if value[:option] == :destroy
      # we initiate the scale first so it won't break if scale is destroy twice,
      # else : destroy scale then clear view will crash
      jq_get(atome_id).resizable()
    end
    jq_get(atome_id).resizable(option)
    jq_get(atome_id).resize do
      if type == :text
        @width = atomise(:width, jq_get(atome_id).css("width").to_i)
        @height = atomise(:height, jq_get(atome_id).css("height").to_i)
        size = @width.q_read / 5
        jq_get(atome_id).css("font-size", size.to_s + "px")
      else
        self.width(jq_get(atome_id).css("width").to_i, false)
        self.height(jq_get(atome_id).css("height").to_i, false)
      end
      value[:proc].call(self.width, self.height) if value[:proc].is_a?(Proc)
    end
  end

  def drop_html(value)
    if value != false
      proc = value[:proc]
      jq_get(atome_id).droppable
      current_atome = self
      jq_get(atome_id).on(:drop) do |evt, ui|
        proc.call(evt, ui, current_atome) if proc.is_a?(Proc)
      end
    else
      jq_get(atome_id).droppable(:destroy)
    end
  end

  def over_html(value)
    if value != false
      proc = value[:proc]
      option = value[:options]
      case option
      when :enter, :in
        jq_get(atome_id).mouseenter do |evt|
          # proc.call(evt) if proc.is_a?(Proc)
          instance_exec evt, &proc if proc.is_a?(Proc)

        end
      when :exit, :leave, :out
        jq_get(atome_id).mouseleave do |evt|
          # proc.call(evt) if proc.is_a?(Proc)
          instance_exec evt, &proc if proc.is_a?(Proc)
        end
      when :remove
        jq_get(atome_id).unbind(:mouseenter)
        jq_get(atome_id).unbind(:mouseleave)
        jq_get(atome_id).unbind(:mouseover)
      else
        jq_get(atome_id).mouseover do |evt|
          # proc.call(evt) if proc.is_a?(Proc)
          instance_exec evt, &proc if proc.is_a?(Proc)
        end
      end
    else
      jq_get(atome_id).unbind(:mouseenter)
      jq_get(atome_id).unbind(:mouseleave)
      jq_get(atome_id).unbind(:mouseover)
    end

  end

  def virtual_event_html(value)
    case value[:event]
    when :touch
      if value[:x] && value[:y]
        jq_get(atome_id).trigger("click", [value[:x], value[:y], value[:x]])
      else
        jq_get(atome_id).trigger("click")
      end
    else
      jq_get(atome_id).trigger(value[:event])
    end
  end

end
