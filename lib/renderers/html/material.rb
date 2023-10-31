# frozen_string_literal: true

new({ method: :overflow, renderer: :html, type: :string }) do |params, bloc|
  html.overflow(params, bloc)
end

new({ method: :remove, renderer: :html, type: :string }) do |object_id_to_remove, bloc|
  if object_id_to_remove.instance_of? Hash
    case object_id_to_remove[:all]
    when :color
      color_id_found = apply.dup
      color_id_found.each do |colo_applied|
        remove(colo_applied)
      end
    end

  else
    atome_to_remove = grab(object_id_to_remove)
    atome_type_found = atome_to_remove.type
    case atome_type_found
    when :color
      if @apply == []
        # we remove the last color set
        # html.style(:background, "")
        html.style(:background, :black)
      else
        # we reset background
        html.style(:background, "")
        render(:apply, atome_to_remove)
      end
    when :shadow

    else
    end
  end

end


new({ method: :paint, renderer: :html, type: :hash }) do |params, _bloc|
  diffusion = params[:diffusion] || :linear
  if params[:direction] && diffusion == :linear
    direction = " to #{params[:direction]},"
  elsif diffusion == :linear
    direction = " to bottom,"
  end
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
  params
end