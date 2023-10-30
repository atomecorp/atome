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
