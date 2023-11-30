# frozen_string_literal: true

new({ method: :overflow, renderer: :html, type: :string }) do |params, bloc|
  html.overflow(params, bloc)
end

new({ method: :gradient, renderer: :html, type: :hash })

new({ method: :remove, renderer: :html, type: :string }) do |object_id_to_remove, bloc|

  if object_id_to_remove.instance_of? Hash
    object_id_to_remove.each do |particle, value|
      case particle
      when :category
        html.remove_class(value)
      else
        atome_ids_found = send(object_id_to_remove[:all])
        atome_ids_found.each do |atome_id|
          remove(atome_id)
        end
      end
    end



  else

    atome_to_remove = grab(object_id_to_remove)
    atome_type_found = atome_to_remove.type
    case atome_type_found
    when :color
      if color == []
        # we remove the last color set
        html.style(:backgroundColor, :black)
      else
        html.style(:background, '')
        html.style(:backgroundColor, '')
        @apply.delete(object_id_to_remove)
        apply(@apply)
      end
    when :shadow
      html.style("boxShadow", 'none')
      html.style("filter", 'none')
      @apply.delete(object_id_to_remove)
      apply(@apply)
    when :paint
      atome_to_remove = grab(object_id_to_remove)
      atome_to_remove.gradient.each do |color_id|
        html.style(:background, '')
        html.style(:backgroundColor, '')
        @apply.delete(color_id)
      end
      @apply.delete(object_id_to_remove)
      apply(@apply)
    end
  end
end
