module HtmlHelpers
  def delete_html(val)
    if val ==true
      jq_get(atome_id).remove
    else
      # send("#{val}_html", 0)
      jq_get(atome_id).css("background-image", "");
    end

  end

  def play_html(options, proc)
    js_play(options, proc)
  end

  def resize_html(value = true, &proc)
    if value == false
      Element.find(JSUtils.device).off(:resize, nil)
    else
      Element.find(JSUtils.device).resize(:resize) do
        width = jq_get(:view).css("width").sub("px", "").to_i
        height = jq_get(:view).css("height").sub("px", "").to_i
        proc.call({ width: width, height: height }) if proc.is_a?(Proc)
      end
    end
  end

  def scroll_html(&proc)
    jq_get(atome_id).scroll do
      proc.call if proc.is_a?(Proc)
    end
  end

  def update_position

    # this method update the position in x, y,xx,yy properties
    jq_object = jq_get(atome_id)
    x_position = jq_object.css("left").sub("px", "").to_i
    y_position = jq_object.css("top").sub("px", "").to_i
    xx_position = jq_object.css("right").sub("px", "").to_i
    yy_position = jq_object.css("bottom").sub("px", "").to_i
    @x = atomise(:x, x_position)
    @y = atomise(:y, y_position)
    @xx = atomise(:x, xx_position)
    @yy = atomise(:y, yy_position)
  end

  def change_position_origin
    jq_get(atome_id).css("left", "#{x}px")
    jq_get(atome_id).css("right", "auto")
    jq_get(atome_id).css("top", "#{y}px")
    jq_get(atome_id).css("bottom", "auto")
    if alignment && alignment[:horizontal] == :xx
      jq_get(atome_id).css("left", "auto")
      jq_get(atome_id).css("right", "#{xx}px")
      jq_get(atome_id).css("top", "auto")
      jq_get(atome_id).css("bottom", "#{yy}px")
    end
    if alignment && alignment[:vertical] == :yy
      jq_get(atome_id).css("left", "auto")
      jq_get(atome_id).css("right", "#{xx}px")
      jq_get(atome_id).css("top", "auto")
      jq_get(atome_id).css("bottom", "#{yy}px")
    end

  end

  # anim
  def animate_html(params)
    JSUtils.animator(params)
  end

  def ping_html(adress, error, success)
    JSUtils.ping(adress, error, success)
  end

  # events's helper

  def touch_html_helper(value)
    if value.instance_of?(Array)
      value.each do |val|
        touch_html_helper(val)
      end
    elsif value[:remove]
      # jq_get(atome_id).unbind("drag touchstart mousedown")
      jq_get(atome_id).off('click')
    else
      option = value[:option]
      delay = value[:delay] || 1.2
      case option
      when :down
        jq_get(atome_id).on("touchstart mousedown") do |evt|
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be treated twice by android browser
          value[:proc].call(evt) if value[:proc].is_a?(Proc)
          evt.stop_propagation if value[:stop]
        end
      when :up
        jq_get(atome_id).on("touchend mouseup") do |evt|
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be traeted twice by android browser
          evt.prevent
          value[:proc].call(evt) if value[:proc].is_a?(Proc)
          evt.stop_propagation if value[:stop]
        end
      when :long
        waiter = ""
        jq_get(atome_id).on("touchstart mousedown") do |evt|
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be treated twice by android browser
          evt.prevent
          waiter = ATOME.wait delay do
            unless drag && drag[:drag] == :moving
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
          ATOME.clear({ wait: waiter })
        end
      else
        jq_get(atome_id).on(:click) do |evt|
          # the method below is used when a browser received touchdown and mousedown at the same time
          # this avoid the event to be traeted twice by android browser
          evt.prevent
          # modification below to allow self with proc ( proc / lambda change conetxt)
          instance_exec evt, &value[:proc] if value[:proc].is_a?(Proc)
          evt.stop_propagation if value[:stop]
        end
      end
    end
  end

end