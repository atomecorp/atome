module PropertyHtml

  def touch_html(value)
    # @@prevent_up_event=:poil
    if value.instance_of?(Array)
      jq_get(atome_id).unbind("touchstart mousedown touchend mouseup")
      jq_get(atome_id).off('click')
      # current_atome="##{atome_id}"
      # `$(#{current_atome}).off('click');`
      value.each do |val|
        # jq_get(atome_id).off('click')
        touch_html(val)
      end
    elsif value[:remove]
      jq_get(atome_id).unbind("drag touchstart mousedown")
      jq_get(atome_id).off('click')
      # current_atome="##{atome_id}"
      # `$(#{current_atome}).off('click');`
    else
      option = value[:option]
      delay = value[:delay] || 1.2
      case option
      when :down
        jq_get(atome_id).on("touchstart mousedown") do |evt|
          # alert "#{evt.type} : #{@verif} on #{atome_id}"
          # alert "#{evt.type}"
          # @verif+=1
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be traeted twice by android browser
          # evt.prevent
          value[:proc].call(evt) if value[:proc].is_a?(Proc)
          evt.stop_propagation if value[:stop]
          ############
        end
      when :up
        # jq_get(atome_id).on("touchstart mousedown") do |evt|
        #   @allow_up_event = true
        # end

        jq_get(atome_id).on("touchend mouseup") do |evt|
          # alert @@prevent_up_event
          # grab(:verification).content(:up)
          # if @allow_up_event == true
            # alert  "atome : #{atome_id}, prevent : #{self.prevent}"

            # the method below is used when a browser received touchdown and mousedown at the same time
            # this avoid the event to be traeted twice by android browser
            evt.prevent
            value[:proc].call(evt) if value[:proc].is_a?(Proc)
            evt.stop_propagation if value[:stop]
            # @allow_up_event = false
          # end
          # @@prevent_up_event = false
        end
      when :long
        # @prevent_up_event = true

        waiter = ""
        jq_get(atome_id).on("touchstart mousedown") do |evt|
          # grab(:verification).content(@prevent_up_event)
          # @@prevent_up_event = true
          # alert @@prevent_up_event
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be treated twice by android browser
          evt.prevent
          waiter = ATOME.wait delay do
            # @allow_up_event = true

            # alert  self.prevent
            # self.prevent(true)
            # alert  "#{atome_id} #{self.prevent}"
            # alert @@prevent_up_event
            unless drag && drag[:drag] == :moving
              # @@prevent_up_event = false
              value[:proc].call(evt) if value[:proc].is_a?(Proc)
              evt.stop_propagation if value[:stop]
            end
          end
          # below we catch the mous out to stop long touch from beeing executed
          grab(atome_id).over(:exit) do
            ATOME.clear({ wait: waiter })
            evt.stop_propagation if value[:stop]
          end
          evt.stop_propagation if value[:stop]
          # @@prevent_up_event = true
        end
        jq_get(atome_id).on("touchend mouseup") do |evt|
          ATOME.clear({ wait: waiter })
          evt.stop_propagation if value[:stop]
        end
      when :double
        ready = false
        jq_get(atome_id).on("touchstart mousedown") do |evt|
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be traeted twice by android browser
          evt.prevent
          if ready == false
            @touch_counter = 0
            ready = true
          end
          waiter = ATOME.wait delay do
            ready = false
            @touch_counter = 0
          end
          if @touch_counter >= 1
            value[:proc].call(evt) if value[:proc].is_a?(Proc)
            clear({ wait: waiter })
            ready = false
            @touch_counter = 0
          end
          @touch_counter += 1
        end
        jq_get(atome_id).on("touchend mouseup") do
          #   ATOME.clear({ wait: waiter })
        end

      else
        jq_get(atome_id).on(:click) do |evt|
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be traeted twice by android browser
          evt.prevent
          # value[:proc].call(evt) if value[:proc].is_a?(Proc)
          # modification below to allow self with proc ( proc / lambda change conetxt)
          instance_exec evt, &value[:proc] if value[:proc].is_a?(Proc)
          evt.stop_propagation if value[:stop]
        end
      end

    end

  end

  ############ base
  # def touch_html(value)
  #   @verif=0
  #   jq_get(atome_id).on("touchstart mousedown") do |evt|
  #   #   jq_get(atome_id).on("touchstart ") do |evt|
  #
  #     view_width=grab(:view).convert(:width)
  #     view_height=grab(:view).convert(:height)
  #   safety=true
  #     # grab(:infos).content("type: #{evt.type}, x: #{evt.page_x},y: #{evt.page_y}, screen width :#{view_width} screen height :#{view_height}")
  #
  #   # if safety
  #     grab(:infos).content("#{evt.type}, event nb: #{@verif}")
  #     @verif+=1
  #     safety=false
  #   # end
  #
  #     # grab(:infos).content("type: #{evt.type}, x: #{evt.touch_x},y: #{evt.touch_y}, screen width :#{view_width} screen height :#{view_height}")
  #     # grab(:infos).content("#{evt.touch_x}\n#{evt.touch_y}")
  #     # alert ("#{evt.touch_x}\n#{evt.touch_y}")
  #     # value[:proc].call(evt) if value[:proc].is_a?(Proc)
  #   end
  #
  # end

  ################### test

  # def touch_html(value)
  #   @verif=0
  #   # jq_get(atome_id).on("touchstart mousedown") do |evt|
  #   jq_get(atome_id).on(:click) do |evt|
  #
  #     alert value
  #
  #     # safety=:true
  #     # if safety==:true
  #     grab(:infos).content("#{evt.type}, event nb: #{@verif}")
  #     @verif+=1
  #     evt
  #     # false
  #     # end
  #   end
  #
  # end

  ############### bug
  # def touch_html(value)
  #   jq_get(atome_id).on("touchstart mousedown") do |evt|
  #     grab(:infos).content(evt.type)
  #   end
  # end

  def drag_html(value)
    jq_object = jq_get(atome_id)
    value = {} if value == true
    if value == :destroy || value[:option] == :destroy
      # we initiate the scale first so it won't break if scale is destroy twice,
      # else : destroy scale then clear view will crash
      # jq_get(atome_id).draggable
      jq_object.draggable(:destroy)
    elsif value == :disable || value[:option] == :disable
      # we initiate the scale first so it won't break if scale is diasble twice,
      # else : destroy scale then clear view will crash
      # jq_get(atome_id).draggable
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
        value[:proc].call(evt) if value[:proc].is_a?(Proc)
      end
      jq_object.on(:drag) do |evt|
        # # tests
        # puts @on_change
        # # grab(self.change[:atome_id]).send(self.change[:property],evt.page_x)
        # grab(@on_change[:atome_id]).send(@on_change[:property],evt.page_x)
        # value[:proc].call(evt) if value[:proc].is_a?(Proc)
        # if @on_change[:property]== :x
        #   @on_change[:proc].call(evt.page_x) if @on_change[:proc].is_a?(Proc)
        # end
        # # # tests
        drag[:drag] = :moving
        evt.start = false
        evt.stop = false
        offset_x = evt.page_x - x_position_start
        offset_y = evt.page_y - y_position_start
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        # we send the position to the proc
        value[:proc].call(evt) if value[:proc].is_a?(Proc)
        # we update the position of the atome
        update_position
      end
      jq_object.on(:dragstop) do |evt|
        drag[:drag] = true
        evt.offset_x = offset_x
        evt.offset_y = offset_y
        evt.start = false
        evt.stop = true
        change_position_origin
        value[:proc].call(evt) if value[:proc].is_a?(Proc)
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
      jq_get(atome_id).on(:drop) do |evt|
        proc.call(evt) if proc.is_a?(Proc)
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
          proc.call(evt) if proc.is_a?(Proc)
        end
      when :exit, :leave, :out
        jq_get(atome_id).mouseleave do |evt|
          proc.call(evt) if proc.is_a?(Proc)
        end
      else
        jq_get(atome_id).mouseover do |evt|
          proc.call(evt) if proc.is_a?(Proc)
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
      jq_get(atome_id).trigger("click")
    end
  end

end
