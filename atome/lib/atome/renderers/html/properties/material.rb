module PropertyHtml
  def color_html(values)
    angle = 180
    diffusion = "linear"
    if type == :text
      # we use a stencil to allow gradient in text
      jq_get(atome_id).css("-webkit-background-clip", "text")
      jq_get(atome_id).css("-webkit-text-fill-color", "transparent")
    end
    if self.type== :shape && self.path
      # in this case we're on a vector file
      `$('#the_path').children().css({fill: 'blue'})`
      `$('#the_path').children().css({stroke: 'red'})`
      # `$('#blur').css({fill: 'blue'})`
      # `$('#blur').css({stroke: 'red'})`
      alert 'html properties render message'
      else
      # we exclude the case when the path is defined because it means we need to use a svg
      if !values.instance_of?(Array) || values.length == 1
        if values.instance_of?(Array)
          value = values[0]
        else
          value = values
        end
        color = color_helper(value)
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
    if value.instance_of?(Array)
      value.each do |shadow|
        shadow_html(shadow)
      end
    else
      shadow_html_format=shadow_helper(value)
      jq_get(atome_id).css(shadow_html_format[0],shadow_html_format[1])
    end

  end

  def fill_html(value)
    self.x = self.y = 0
    size=""
    number=""
    if value.class == Hash
      target = value[:target]
      size = value[:size]
      number = value[:number]
    else
      target = if value.class == Atome
                 value
               else
                 get(value)
               end
    end
    if size.nil?
      size = self.size
    end
    width = if target.width.class == String && target.width.end_with?("%")
              target.convert(:width)
            else
              target.width
            end
    height = if target.height.class == String && target.width.end_with?("%")
               target.convert(:height)
             else
               target.height
             end
    jq_get(atome_id).css('width', width)
    jq_get(atome_id).css('height', height)
    jq_get(atome_id).css('background-repeat', 'space')
    if number
      size = width / number
    else
    end
    jq_get(atome_id).css('background-size', size)
  end
end