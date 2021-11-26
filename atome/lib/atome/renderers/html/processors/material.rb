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
      value = value[:content] || "rgba(#{red},#{green},#{blue},#{alpha})"
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
               ''
             end
    if value[:bounding] == true || invert == :inset
      prev_prop = jq_get(atome_id).css('box-shadow')
      prev_prop = if prev_prop == 'none'
                    ''
                  else
                    "#{prev_prop}, "
                  end
      shadow_html_format = ['box-shadow',
                            "#{prev_prop}#{x}px #{y}px #{blur}px #{thickness}px #{color} #{invert}"]
    else
      prev_prop = previous_filter_found

      shadow_html_format = ['filter',
                            "#{prev_prop}drop-shadow(#{x}px #{y}px #{blur}px #{color})"]
    end
    shadow_html_format
  end
end
