module ProcessorHtml
  def color_helper(value)
    case value
    when Hash
      red = if value[:red]
              value[:red] * 255
            else
              0
            end
      green = if value[:green]
                value[:green] * 255
              else
                0
              end
      blue = if value[:blue]
               value[:blue] * 255
             else
               0
             end
      alpha = if value[:alpha]
                value[:alpha] * 1
              else
                1
              end
      if value[:content]
        value = value[:content]
      else
        value = "rgba(#{red},#{green},#{blue},#{alpha})"
      end
    else
      value
    end
    value
  end

  def shadow_helper(value)
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
    if thickness != 0 || invert ==:inset
      prev_prop = jq_get(atome_id).css('box-shadow')
      if prev_prop == "none"
        prev_prop = ""
      else
        prev_prop = "#{prev_prop}, "
      end
      shadow_html_format = ["box-shadow", prev_prop + x.to_s + "px " + y.to_s + "px " + blur.to_s + "px " + thickness.to_s + "px " + color + " " + invert]
    else
      prev_prop = previous_filer_found
      shadow_html_format = ['filter', prev_prop + "drop-shadow(" + x.to_s + "px " + y.to_s + "px " + blur.to_s + "px " + color + ")"]
    end
    shadow_html_format
  end
end