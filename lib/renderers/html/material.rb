# frozen_string_literal: true

new({ method: :overflow, renderer: :html, type: :string }) do |params, bloc|
  html.overflow(params, bloc)
end

new({ method: :gradient, renderer: :html, type: :hash })

new({ method: :remove, renderer: :html, type: :string }) do |object_id_to_remove, bloc|

  if object_id_to_remove.instance_of? Hash
    atome_ids_found = send(object_id_to_remove[:all])
    atome_ids_found.each do |atome_id|
      remove(atome_id)
    end

  else

    atome_to_remove = grab(object_id_to_remove)
    # alert atome_to_remove.id
    atome_type_found = atome_to_remove.type
    case atome_type_found
    when :color
      if color == []
        # we remove the last color set
        # html.style(:background, '')
        # html.style(:background, :black)
        html.style(:backgroundColor, :black)
      else
        html.style(:background, '')
        html.style(:backgroundColor, '')
        @apply.delete(object_id_to_remove)
        apply(@apply)
      end
    when :shadow
      # shadows_to_apply[:filter] << "drop-shadow(#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}))"
      # shadows_to_apply[:boxShadow] << "#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) #{inset}"
      # shadows_to_apply[:filter]=
      #  shadows_to_apply[:boxShadow]='none'
      # element.style.boxShadow = 'none';
      html.style("boxShadow", 'none')
      html.style("filter", 'none')
      # // Supprimer les ombres de texte, si nécessaire
      # element.style.textShadow = 'none';
      @apply.delete(object_id_to_remove)
      apply(@apply)
      # alert "shadow to remove #{object_id_to_remove}\n#{grab(object_id_to_remove).inspect}"
    when :paint
      atome_to_remove = grab(object_id_to_remove)
      atome_to_remove.gradient.each do |color_id|
        html.style(:background, '')
        html.style(:backgroundColor, '')
        @apply.delete(color_id)
      end
      @apply.delete(object_id_to_remove)
      apply(@apply)
    else
      #
    end
  end

end
