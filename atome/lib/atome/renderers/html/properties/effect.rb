module PropertyHtml
  def blur_html(value)
    # the line below get  any filter all already apply to the object
    prev_prop = previous_filer_found
    case value
    when Array
      properties = []
      value.each do |param|
        properties << param.to_s + 'px'
      end
      properties.join(" ").to_s
    when Hash
      if value[:invert]
        jq_get(atome_id).css('backdrop-filter', 'blur(' + value[:value].to_s + 'px)')
      else
        jq_get(atome_id).css('filter', prev_prop + 'blur(' + value[:value].to_s + 'px)')
      end
    when String, Symbol, Number
      jq_get(atome_id).css('filter', prev_prop + 'blur(' + value.to_s + 'px)')
    else
      ""
    end
  end

  def shadow_html(value)

    if value.instance_of?(Array)
      value.each do |shadow|
        shadow_html(shadow)
      end
    elsif value==:delete
      jq_get(atome_id).css("box-shadow", "0px 0px  0px  0px")
      jq_get(atome_id).css("filter", "drop-shadow( 0px 0px 0px )")
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
                          properties << param.to_s + "px"
                        end
                        properties.join(" ").to_s
                      when Integer
                        value
                      else
                        value
                      end
    jq_get(atome_id).css("border-radius", formated_params)
  end


  def mask_html(value)
    mask_path= $images_list[value[:content]][:path]
    repeat=value[:repeat]
    case repeat
    when false
      repeat="no-repeat"
    when true
      repeat="repeat"
    when "x"
      repeat="repeat-x"
      when "y"
        repeat="repeat-y"
    else
      repeat="no-repeat"
    end
    jq_get(atome_id).css("-webkit-mask-image": "url(#{mask_path})","-webkit-mask-size": "#{value[:size]}px","-webkit-mask-position": "#{value[:position]}","-webkit-mask-repeat": repeat)
    jq_get(atome_id).css("mask-image": "url(#{mask_path})","mask-size": "#{value[:size]}px","mask-position": "#{value[:position]}","mask-repeat": repeat)

  end

  def clip_html(value)
    jq_get(atome_id).css("clip-path": "url(##{value[:path]})")
  end

  def noise_html(value)
    `generateNoise(#{atome_id},100,0.6, 633, 633,false); // target, intensity, opacity, width, height, color`
  end
end