# frozen_string_literal: true

new({ renderer: :html, method: :attach, type: :string }) do |parent_found, _user_proc|
  html.append_to(parent_found)
end


new({ renderer: :html, method: :apply, type: :string }) do |parent_found, _user_proc|

  # TODO : factorise code below between text and shape, especially shadow as code is written twice and identical
  case parent_found.type
  when :shadow
    shadows_to_apply = { filter: [], boxShadow: [] }
    shadow.each do |shadow_id_found|
      shadow_found = grab(shadow_id_found)
      red = shadow_found.red * 255
      green = shadow_found.green * 255
      blue = shadow_found.blue * 255
      alpha = shadow_found.alpha
      left = shadow_found.left
      top = shadow_found.top
      blur = shadow_found.blur[:value] # new correct behavior all atome's value should now be get using :value,here to resolve conflict  with blur and back blur
      inset = :inset if shadow_found.invert
      if shadow_found.option == :natural
        shadows_to_apply[:filter] << "drop-shadow(#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}))"
      else
        shadows_to_apply[:boxShadow] << "#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) #{inset}"
      end
    end
    drop_shadow = shadows_to_apply[:filter].join(' ')
    box_shadow = shadows_to_apply[:boxShadow].join(',')
    html.style("transform", "translate3d(0, 0, 0)")
    html.style("boxShadow", box_shadow)
    html.style("filter", drop_shadow)
  when :color
    red = parent_found.red * 255
    green = parent_found.green * 255
    blue = parent_found.blue * 255
    alpha = parent_found.alpha
    if type.to_sym ==:border
      affect.each do |at_found|
        grab(at_found).html.style(:border, "solid 2px rgba(#{red},#{green},#{blue},#{alpha})")
      end
    elsif type.to_sym == :image
      # alert 'rr'
      # div[:style][:mixBlendMode] = 'color'
      # html.style(:mixBlendMode,'color')
      # html.style(:backgroundColor, "rgba(#{red}, #{green}, #{blue}, #{alpha})")

      # html.image_colorizer("rgba(#{red}, #{green}, #{blue}, #{alpha})")
      # html.image_colorizer("rgba(#{red}, #{green}, #{blue}, #{alpha})")
    else
          html.style(:backgroundColor, "rgba(#{red}, #{green}, #{blue}, #{alpha})")


    end
  when :paint
    # if when found colors when use it for the gradient , else whe use the colors within the current atome
    # gradient_found = params[:colors] || @apply
    # we get all the paint atomes applied to the current atome
    gradients_to_apply = []
    paint.each do |paint_id|
      colors_to_apply = []
      # now we get the paint atome
      paint_atome = grab(paint_id)
      paint_diffusion = paint_atome.diffusion
      paint_direction = paint_atome.direction
      diffusion = paint_diffusion || :linear
      if paint_direction && paint_direction == :linear
        direction = " to #{params[:direction]},"
      elsif diffusion == :linear
        direction = ' to bottom,'
      end

      direction = "#{paint_atome.rotate}deg," if paint_atome.rotate

      # now we get the gradient and the color insied
      paint_atome.gradient.each do |color_id|
        color_found = grab(color_id)
        red = color_found.red * 255
        green = color_found.green * 255
        blue = color_found.blue * 255
        alpha = color_found.alpha
        colors_to_apply << "rgba(#{red}, #{green}, #{blue}, #{alpha})"
      end
      colors_to_apply = colors_to_apply.join(',')
      gradients_to_apply << "#{diffusion}-gradient(#{direction} #{colors_to_apply})"
    end
    # TODO : create complexe gradient staking the gradients uncommenting the line below
    # beware the colors_to_apply syntax is incorrect for complexe gradient
    # full_gradient_to_apply=gradients_to_apply.join(',')
    full_gradient_to_apply = gradients_to_apply.last
    html.style(:background, full_gradient_to_apply)
  when :border
    border.each do |border_id_found|
      border_found = grab(border_id_found)
      red = border_found.red * 255
      green = border_found.green * 255
      blue = border_found.blue * 255
      alpha = border_found.alpha
      thickness = border_found.thickness
      pattern = border_found.pattern
      html.style(:border, "#{pattern} #{thickness}px rgba(#{red},#{green},#{blue},#{alpha})")
    end
  else
    #
  end
end

new({ renderer: :html, method: :apply, type: :string, specific: :text }) do |parent_found, _user_proc|
  # TODO:   we should treat objet when multiple : #{self.inspect}
  case parent_found.type
  when :shadow
    shadows_to_apply = { filter: [], boxShadow: [] }
    shadow.each do |shadow_id_found|
      shadow_found = grab(shadow_id_found)
      red = shadow_found.red * 255
      green = shadow_found.green * 255
      blue = shadow_found.blue * 255
      alpha = shadow_found.alpha
      left = shadow_found.left
      top = shadow_found.top
      blur = shadow_found.blur[:value] # new correct behavior all atome's value should now be get using :value,here to resolve conflict  with blur and back blur
      inset = :inset if shadow_found.invert
      if shadow_found.option == :natural
        shadows_to_apply[:filter] << "drop-shadow(#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}))"
      else
        shadows_to_apply[:boxShadow] << "#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) #{inset}"
      end
    end
    drop_shadow = shadows_to_apply[:filter].join(' ')
    box_shadow = shadows_to_apply[:boxShadow].join(',')
    html.style("transform", "translate3d(0, 0, 0)")
    html.style("boxShadow", box_shadow)
    html.style("filter", drop_shadow)
  when :color
    red = parent_found.red * 255
    green = parent_found.green * 255
    blue = parent_found.blue * 255
    alpha = parent_found.alpha
    html.style(:color, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
  when :paint
    # if when found colors when use it for the gradient , else whe use the colors within the current atome
    # gradient_found = params[:colors] || @apply
    # we get all the paint atomes applied to the current atome
    gradients_to_apply = []
    paint.each do |paint_id|
      colors_to_apply = []
      # now we get the paint atome
      paint_atome = grab(paint_id)
      paint_diffusion = paint_atome.diffusion
      paint_direction = paint_atome.direction
      diffusion = paint_diffusion || :linear
      if paint_direction && paint_direction == :linear
        direction = " to #{params[:direction]},"
      elsif diffusion == :linear
        direction = ' to bottom,'
      end

      if paint_atome.rotate
        direction = "#{paint_atome.rotate}deg,"
      end

      # now we get the gradient and the color insied
      paint_atome.gradient.each do |color_id|
        color_found = grab(color_id)
        red = color_found.red * 255
        green = color_found.green * 255
        blue = color_found.blue * 255
        alpha = color_found.alpha
        colors_to_apply << "rgba(#{red}, #{green}, #{blue}, #{alpha})"
      end
      colors_to_apply = colors_to_apply.join(',')
      gradients_to_apply << "#{diffusion}-gradient(#{direction} #{colors_to_apply})"
    end
    # TODO : create complexe gradient staking the gradients uncommenting the line below
    # beware the colors_to_apply syntax is incorrect for complexe gradient
    # full_gradient_to_apply=gradients_to_apply.join(',')
    full_gradient_to_apply = gradients_to_apply.last

    html.style(:backgroundClip, 'text')
    html.style(:color, 'transparent')
    html.style(:backgroundImage, full_gradient_to_apply)
  end

end

new({ renderer: :html, method: :apply, type: :string, specific: :vector }) do |parent_found, _user_proc|

  # TODO : factorise code below between text and shape, especially shadow as code is written twice and  identical
  case parent_found.type
  when :shadow
    shadows_to_apply = { filter: [], boxShadow: [] }
    shadow.each do |shadow_id_found|
      shadow_found = grab(shadow_id_found)
      red = shadow_found.red * 255
      green = shadow_found.green * 255
      blue = shadow_found.blue * 255
      alpha = shadow_found.alpha
      left = shadow_found.left
      top = shadow_found.top
      blur = shadow_found.blur
      inset = :inset if shadow_found.invert
      if shadow_found.option == :natural
        shadows_to_apply[:filter] << "drop-shadow(#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}))"
      else
        shadows_to_apply[:boxShadow] << "#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) #{inset}"
      end
    end
    drop_shadow = shadows_to_apply[:filter].join(' ')
    box_shadow = shadows_to_apply[:boxShadow].join(',')
    html.style("transform", "translate3d(0, 0, 0)")
    html.style("boxShadow", box_shadow)
    html.style("filter", drop_shadow)
  when :color
    red = parent_found.red * 255
    green = parent_found.green * 255
    blue = parent_found.blue * 255
    alpha = parent_found.alpha
    html.colorize_svg_data("rgba(#{red}, #{green}, #{blue}, #{alpha})")
  when :paint

    # if when found colors when use it for the gradient , else whe use the colors within the current atome
    # gradient_found = params[:colors] || @apply
    # we get all the paint atomes applied to the current atome
    gradients_to_apply = []
    paint.each do |paint_id|
      colors_to_apply = []
      # now we get the paint atome
      paint_atome = grab(paint_id)
      paint_diffusion = paint_atome.diffusion
      paint_direction = paint_atome.direction
      diffusion = paint_diffusion || :linear
      if paint_direction && paint_direction == :linear
        direction = " to #{params[:direction]},"
      elsif diffusion == :linear
        direction = ' to bottom,'
      end

      direction = "#{paint_atome.rotate}deg," if paint_atome.rotate

      # now we get the gradient and the color insied
      paint_atome.gradient.each do |color_id|
        color_found = grab(color_id)
        red = color_found.red * 255
        green = color_found.green * 255
        blue = color_found.blue * 255
        alpha = color_found.alpha
        colors_to_apply << "rgba(#{red}, #{green}, #{blue}, #{alpha})"
      end
      colors_to_apply = colors_to_apply.join(',')
      gradients_to_apply << "#{diffusion}-gradient(#{direction} #{colors_to_apply})"
    end
    # TODO : create complexe gradient staking the gradients uncommenting the line below
    # beware the colors_to_apply syntax is incorrect for complexe gradient
    # full_gradient_to_apply=gradients_to_apply.join(',')
    full_gradient_to_apply = gradients_to_apply.last
    html.style(:background, full_gradient_to_apply)
  else
    # type code here
  end
end
