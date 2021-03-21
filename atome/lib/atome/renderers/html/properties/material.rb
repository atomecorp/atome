module PropertylHtml
  def color_html(value)
    values = value.read
    color = "background-image"
    unless values.instance_of?(Array)
      values = [values]
    end
    values.each do |val|
      val = color_helper(val)
      if type == :text
        jq_get(atome_id).css("-webkit-text-fill-color", val)
      else
        val = "linear-gradient(0deg," + val + ", " + val + ")"
        jq_get(atome_id).css(color, val)
      end
    end
  end

  def opacity_html(value)
    value = value.read
    jq_get(atome_id).css(:opacity, value)
  end

  def border_html(value)
    value = value.read
    pattern = value[:pattern]
    thickness = value[:thickness]
    color = color_helper(value[:color])
    jq_get(atome_id).css("border", thickness.to_s + "px " + pattern + " " + color)
  end

  def overflow_html(value)
    value = value.read
    if value.instance_of?(Hash)
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
      jq_get(atome_id).css("overflow", value)
    end
  end

  def shadow_html(value)
    value = value.read
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