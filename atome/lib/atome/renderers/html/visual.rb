module HtmlVisual
  def color_html(value)
    color = "background-image"
    value = color_helper(value)
    if type == :text
      jq_get(atome_id).css("-webkit-text-fill-color", value)
    else
      value = "linear-gradient(0deg," + value + ", " + value + ")"
      jq_get(atome_id).css(color, value)
    end
  end

  def opacity_html(value)
    jq_get(atome_id).css(:opacity, value)
  end

  def border_html(value)
    pattern = value[:pattern]
    thickness = value[:thickness]
    color = color_helper(value[:color])
    jq_get(atome_id).css("border", thickness.to_s + "px " + pattern + " " + color)
  end

  def overflow_html(value)
    if params.instance_of?(Hash)
      x = value[:x]
      y = value[:y]
      if x
        jq_get(atome_id).css("overflow-y", :visible)
        jq_get(atome_id).css("overflow-x", :visible)
      end
      if y
        jq_get(atome_id).css("overflow-y", y)
      end
    else
      jq_get(atome_id).css("overflow", params)
    end
  end

  def shadow_html(value)
    x = value[:x]
    y = value[:y]
    blur = value[:blur]
    thickness = value[:thickness]
    color = color_helper(value[:color])
    invert = if value[:invert]
      :inset
    else
      " "
    end
    if type == :text || type == :image
      jq_get(atome_id).css("filter", "drop-shadow(" + x.to_s + "px " + y.to_s + "px " + blur.to_s + "px " + color + ")")
    else
      jq_get(atome_id).css("box-shadow", x.to_s + "px " + y.to_s + "px " + blur.to_s + "px " + thickness.to_s + "px " + color + " " + invert)
    end
  end
end