module PropertyHtml
  def blur_html(value)
    # the line below get  any filter all already apply to the object
    prev_prop = previous_filter_found
    case value
    when Array
      properties = []
      value.each do |param|
        properties << "#{param}px"
      end
      properties.join(' ').to_s
    when Hash
      if value[:invert]
        jq_get(atome_id).css('backdrop-filter', "blur(#{value[:value]}px)")
      else
        jq_get(atome_id).css('filter', "#{prev_prop}blur(#{value[:value]}px)")
      end
    when String, Symbol, Number
      jq_get(atome_id).css('filter', "#{prev_prop}blur(#{value}px)")
    else
      ''
    end
  end

  def hue_html(value)

    # the line below get  any filter all already apply to the object
    prev_prop = previous_filter_found
    case value
    when Array
      properties = []
      value.each do |param|
        properties << "#{param}px"
      end
      properties.join(' ').to_s

    when Hash
      # hue-rotate(180deg)
      jq_get(atome_id).css('filter', "#{prev_prop}hue-rotate(#{value}deg)")
    when String, Symbol, Number
      jq_get(atome_id).css('filter', "hue-rotate(#{value}deg)")
    else
      ''

    end
  end

  def shadow_html(value)
    if value.instance_of?(Array)
      value.each do |shadow|
        shadow_html(shadow)
      end
    elsif value==:delete
      jq_get(atome_id).css('box-shadow', '0px 0px  0px  0px')
      jq_get(atome_id).css('filter', 'drop-shadow( 0px 0px 0px )')
    else
      shadow_html_format = shadow_helper(value)
      jq_get(atome_id).css(shadow_html_format[0], shadow_html_format[1])
    end
  end

  def smooth_html(value)
    formated_params = case value
                      when Array
                        properties = []
                        value.each do |param|
                          properties << "#{param}px"
                        end
                        properties.join(' ').to_s
                      when Integer
                        value
                      else
                        value
                      end
    jq_get(atome_id).css('border-radius', formated_params)
  end

  def mask_html(value)
    mask_path= $images_list[value[:content]][:path]
    repeat=value[:repeat]
    repeat = case repeat
             when false
               'no-repeat'
             when true
               'repeat'
             when 'x'
               'repeat-x'
             when 'y'
               'repeat-y'
    else
               'no-repeat'
             end
    mask_path= $images_list[value[:content]][:path]
    jq_get(atome_id).css("-webkit-mask-image": "url(#{mask_path})","-webkit-mask-size": "#{value[:size]}px","-webkit-mask-position": "#{value[:position]}","-webkit-mask-repeat": repeat)
    jq_get(atome_id).css("mask-image": "url(#{mask_path})","mask-size": "#{value[:size]}px","mask-position": "#{value[:position]}","mask-repeat": repeat)
  end

  def clip_html(value)
    jq_get(atome_id).css("clip-path": "url(##{value[:path]})")
  end

  def noise_html(value)
    if  value[:width]==:auto
      value[:width]= convert(:width)
    end
    if  value[:height]==:auto
      value[:height]= convert(:height)
    end
    `generateNoise(#{atome_id},#{value[:intensity]},#{value[:opacity]}, #{value[:width]}, #{value[:height]},#{value[:color]},#{value[:delete]}); // target, intensity, opacity, width, height, color`
  end




end