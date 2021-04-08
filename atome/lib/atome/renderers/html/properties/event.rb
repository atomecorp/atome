module PropertyHtml
  def touch_html(value)
    # value = value.read
    proc = value[:proc]
    option = value[:option]
    case option
    when :stop
      jq_get(atome_id).unbind("drag touchstart mousedown")
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

  def drag_html(value)
    # value = value.read
    if value == true
      value = {}
      value[:lock] = ""
    end
    proc = value[:proc]
    jq_object = jq_get(atome_id)
    lock = case value[:lock]
           when :parent
             {containment: "parent"}
           when :x
             {axis: "y"}
           when :y
             {axis: "x"}
           else
             {}
           end
    jq_object.draggable(lock)
    jq_object.on(:drag) do |evt|
      # we send the position to the proc
      proc.call(evt) if proc.is_a?(Proc)
      # we update the position of the atome
      update_position
    end
    jq_object.on(:dragstart) do |evt|
      jq_get(atome_id).css("left", "#{x}px")
      jq_get(atome_id).css("right", "auto")
      jq_get(atome_id).css("top", "#{y}px")
      jq_get(atome_id).css("bottom", "auto")
    end
    jq_object.on(:dragstop) do
      change_position_origin
    end
  end

  def key_html(value)
    # value = value.read
    proc = value[:proc]
    option = value[:option]
    ## the line below is important for the object to get focus if not keypress wont be triggered
    atome = grab(atome_id)
    atome.edit(true)
    if option == :down
      jq_get(atome_id).on("keydown") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
        #evt.prevent_default
      end
    elsif option == :up
      jq_get(atome_id).on("keyup") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    elsif option == :stop
      jq_get(atome_id).unbind("keypress")
      atome.edit(:false)
    else
      jq_get(atome_id).on(:keypress) do |evt|
        #evt.prevent_default
        proc.call(evt) if proc.is_a?(Proc)
      end
    end

  end

end