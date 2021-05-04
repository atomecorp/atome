module PropertyHtml
  def touch_html(value)
    if value[:remove]
      jq_get(atome_id).unbind("drag touchstart mousedown")
    else
      proc = value[:proc]
      option = value[:option]
      case option
      when :down
        jq_get(atome_id).on("touchstart mousedown") do |evt|
          proc.call(evt) if proc.is_a?(Proc)
        end
      when :up
        jq_get(atome_id).on("touchend mouseup") do |evt|
          proc.call(evt) if proc.is_a?(Proc)
        end
      when :long
        jq_get(atome_id).on("touchstart mousedown") do |evt|
          @trig = true
          wait 1.2 do
            if @trig
              proc.call(evt) if proc.is_a?(Proc)
            end
          end
        end
        jq_get(atome_id).on("touchend mouseup") do
          @trig = false
        end
      else
        jq_get(atome_id).on(:click) do |evt|
          proc.call(evt) if proc.is_a?(Proc)
        end
      end
    end

  end

  def drag_html(value)
    jq_object = jq_get(atome_id)
    if value == true
      value = {}
    end
    if value == :destroy || value[:option] == :destroy
      # we initiate the scale first so it won't break if scale is destroy twice,
      # else : destroy scale then clear view will crash
      jq_get(atome_id).draggable()
    end
    if value == :destroy
      jq_object.draggable(:destroy)
    elsif value == :disable
      jq_object.draggable(:disable)
    else
      proc = value[:proc]
      grid = {}
      if value[:grid]
        grid = { grid: [value[:grid][:x], value[:grid][:y]] }
      end
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
      if value[:handle]
        handle = { handle: "#" + value[:handle] }
      else
        handle = {}
      end
      fixed = {}
      if value[:fixed]
        fixed = { opacity: 0.0000000000001, helper: :clone }
      end

      options = lock.merge(handle).merge(containment).merge(grid).merge(fixed).merge({ multiple: true })
      jq_object.draggable(options)
      x_position_start = 0
      y_position_start = 0
      offset_x = 0
      offset_y = 0
      jq_object.on(:dragstart) do |evt|
        evt.start = true
        evt.stop = false
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        jq_get(atome_id).css("left", "#{x}px")
        jq_get(atome_id).css("right", "auto")
        jq_get(atome_id).css("top", "#{y}px")
        jq_get(atome_id).css("bottom", "auto")
        x_position_start = evt.page_x
        y_position_start = evt.page_y
        proc.call(evt) if proc.is_a?(Proc)
      end
      jq_object.on(:drag) do |evt|
        evt.start = false
        evt.stop = false
        offset_x = evt.page_x - x_position_start
        offset_y = evt.page_y - y_position_start
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        # we send the position to the proc
        proc.call(evt) if proc.is_a?(Proc)
        # we update the position of the atome
        update_position
      end
      jq_object.on(:dragstop) do |evt|
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        evt.start = false
        evt.stop = true
        change_position_origin
        proc.call(evt) if proc.is_a?(Proc)
      end
    end

  end

  def key_html(value)
    proc = value[:proc]
    option = value[:option]
    # the lines below is important for the object to get focus if not keypress wont be triggered
    atome = grab(atome_id)
    atome.edit(true)
    if option == :down
      jq_get(atome_id).on("keydown") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
        unless self.type == :text || self.type == :particle
          evt.prevent_default
        end
      end
    elsif option == :up
      jq_get(atome_id).on("keyup") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
        unless self.type == :text || self.type == :particle
          evt.prevent_default
        end
      end
    elsif option == :stop
      jq_get(atome_id).unbind("keypress")
      atome.edit(false)
    else
      jq_get(atome_id).on(:keypress) do |evt|
        unless self.type == :text || self.type == :particle
          evt.prevent_default
        end
        proc.call(evt) if proc.is_a?(Proc)
      end
    end
  end

  def scale_html(value)
    default = { option: { handles: 'all' } }
    unless value.instance_of?(Hash)
      value = { option: value }
    end
    value = default.merge(value)
    option = value[:option]
    if value[:ratio]
      option = option.merge(aspectRatio: true)
    end
    if value[:add]
      option = option.merge(alsoResize: "##{value[:add].to_s}")
    end
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
        size = @width.read / 5
        jq_get(atome_id).css("font-size", size.to_s + "px")
      else
        self.width(jq_get(atome_id).css("width").to_i, false)
        self.height(jq_get(atome_id).css("height").to_i, false)
      end
      proc = value[:proc]
      proc.call(self.width, self.height) if proc.is_a?(Proc)
    end
  end
end