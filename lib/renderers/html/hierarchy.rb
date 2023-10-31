# frozen_string_literal: true

new({ renderer: :html, method: :attach, type: :string }) do |parent_found, _user_proc|
  html.append_to(parent_found)
end

# new({ renderer: :html, method: :attach, type: :string, specific: :color }) do |parent_found, _user_proc|
#   grab(parent_found).apply(id)
# end

new({ renderer: :html, method: :apply, type: :string }) do |parent_found, _user_proc|
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
    alert "shadow rendering: #{inspect}, boxShadow => #{box_shadow}, drop_shadow => #{drop_shadow}"
    html.style("transformr", "translate3d(0, 0, 0)")
    html.style("boxShadow", box_shadow)
    html.style("filter", drop_shadow)
  else
    gradient = @paint[:gradient]

    diffusion = @paint[:diffusion] || :linear
    if @paint[:direction] && diffusion == :linear
      direction = "to #{@paint[:direction]},"
    elsif diffusion == :linear
      direction = 'to bottom,'
    end

    red = parent_found.red * 255
    green = parent_found.green * 255
    blue = parent_found.blue * 255
    alpha = parent_found.alpha
    if gradient
      colors_to_apply = []
      @apply.each do |color_id|
        color_found = grab(color_id)
        red = color_found.red * 255
        green = color_found.green * 255
        blue = color_found.blue * 255
        alpha = color_found.alpha
        colors_to_apply << "rgba(#{red}, #{green}, #{blue}, #{alpha})"
      end
      colors_to_apply = colors_to_apply.join(',')
      html.style(:background, "#{diffusion}-gradient(#{direction} #{colors_to_apply})")
    end
    html.style(:backgroundColor, "rgba(#{red}, #{green}, #{blue}, #{alpha})")

  end
end

new({ renderer: :html, method: :apply, type: :string, specific: :text }) do |parent_found, _user_proc|
  # TODO:   we should treat objet when multiple : #{self.inspect}

  red = parent_found.red * 255
  green = parent_found.green * 255
  blue = parent_found.blue * 255
  alpha = parent_found.alpha
  html.style(:color, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
end


