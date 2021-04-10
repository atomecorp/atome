module PropertyHtml
  def color_html(values)
    angle = 180
    diffusion = :linear
    if type == :text
      # we use a stencil to allow gradient in text
      jq_get(atome_id).css("-webkit-background-clip", "text")
      jq_get(atome_id).css("-webkit-text-fill-color", "transparent")
    end

    if !values.instance_of?(Array) || values.length == 1
      color = color_helper(values)
      val = "linear-gradient(0deg,#{color},#{color})"
      jq_get(atome_id).css("background-image", val)
    else
      gradient = []
      values.each do |color_found|
        if color_found[:angle]
          angle = color_found[:angle]
        end
        if color_found[:diffusion]
          diffusion = color_found[:diffusion]
        end
        gradient << color_helper(color_found)
      end
      case diffusion
      when :linear
        val = "#{diffusion}-gradient(#{angle}deg,#{gradient.join(",")})"
      else
        val = "#{diffusion}-gradient(#{gradient.join(",")})"
      end
      jq_get(atome_id).css("background-image", val)
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
      filter = jq_get(atome_id).css('filter')
      if  filter == "none"
        prev_prop=""
      else
        prev_prop= "#{filter} "
      end
      jq_get(atome_id).css('filter', prev_prop  + "drop-shadow(" + x.to_s + "px " + y.to_s + "px " + blur.to_s + "px " + color + ")")
    else
      # new below
      prev_prop = jq_get(atome_id).css('box-shadow')
      if prev_prop == "none"
        prev_prop=""
      else
        prev_prop = "#{prev_prop}, "
      end
      jq_get(atome_id).css("box-shadow", prev_prop+x.to_s + "px " + y.to_s + "px " + blur.to_s + "px " + thickness.to_s + "px " + color + " " + invert)
    end
  end
end