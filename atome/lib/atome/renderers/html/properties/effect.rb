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
    if  value[:width]==:auto || ( value[:width].class == String && value[:height].include?("%"))
      value[:width]= convert(:width)

    end
    if  value[:height]==:auto || (value[:height].class == String && value[:height].include?("%"))
      value[:height]= convert(:height)
    end

    # old way below
    # `generateNoise(#{atome_id},#{value[:intensity]},#{value[:opacity]}, #{value[:width]}, #{value[:height]},#{value[:color]},#{value[:delete]}); // target, intensity, opacity, width, height, color`

    # temp patch below


    # noise.width(value[:width])
    # noise.height(value[:height])
    # if type ==:text
      # alert atome_id
      # noise=self.image(:noise)
    # fill({target: noise, number: 7})
    # jq_get(atome_id).css("background-image", "././medias/images/noise.svg")

    # jq_get(atome_id).css("-webkit-background-clip", "text")
    # jq_get(atome_id).css("-webkit-text-fill-color", "transparent")

    # "././medias/images/noise.svg"
    # background-image:
    # else
    #   noise=self.image(:noise)
    # jq_get(atome_id).css("background-image", "././medias/images/noise.svg")

    # jq_get(atome_id).prepend("<div>jhgjhgjhg</div>")

#     jq_get(atome_id).prepend("<image style='opacity: #{value[:opacity]} ;display: block; position: absolute;width: 100%;
# height:100%; left: 0px; top: 0px' src='././medias/images/noise.svg' width = 100% height=100%/>")

    #todo : create and parametise svg and use it as background
    # var Canvas = document.createElement("canvas");
    # ... do your canvas drawing....
    # $('body').css({'background-image':"url(" + Canvas.toDataURL("image/png")+ ")" });

    prev_background = jq_get(atome_id).css("background-image")
    jq_get(atome_id).css("background-image", "url(././medias/images/noise.svg), #{prev_background} ")


    # jq_get(atome_id).addClass("noise")

     # jq_get(atome_id).css("background-image","linear-gradient(0deg, red, blue)")
    # atome_background = jq_get(atome_id).css("background-image")
    # alert  atome_background
    # jq_get(atome_id).css("background-color",'blue')
    #   noise.x(0)
    #   noise.y(0)
    #   noise.width("100%")
    #   noise.height("100%")
    #   noise.opacity(value[:opacity])
    #   noise.color(value[:color])
    #   noise.z(-6)
    # end



#   #   `
# 	# <svg  width='100%' height='100%' version='1.1' xmlns='http://www.w3.org/2000/svg' style="opacity: 1">
# 	#    <defs>
#   #     <filter id='noise' >
#   #     	  <feTurbulence type='fractalNoise' baseFrequency='0.7'  numOctaves='2' result='noisy' />
# 	#         <feColorMatrix type='saturate' values='0'/>
#   #       <feBlend in='SourceGraphic' in2='noisy' mode='multiply' />
#   #     </filter>
#   #   </defs>
#   #      <g>
#   #   <rect  stroke='none' fill='rgba(0, 0,0, 0.0)' x='0' y='0' width='100%' height='100%' filter='url(#noise)' />
# 	#    </g>
#   #  </svg>
# #
# # `


  end


end