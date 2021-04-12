module HtmlHelpers
  def delete_html
    jq_get(atome_id).remove
  end

  def play_html(options, &proc)
    video_play(options, proc)
  end

  def resize_html(value=true,&proc)
    if value==:false
      Element.find(JSUtils.device).off(:resize)
    else
      Element.find(JSUtils.device).resize(:resize) do
        width = jq_get(:view).css("width").sub("px", "").to_i
        height = jq_get(:view).css("height").sub("px", "").to_i
        proc.call({width: width, height: height}) if proc.is_a?(Proc)
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

end