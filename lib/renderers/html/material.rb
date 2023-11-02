# frozen_string_literal: true

new({ method: :overflow, renderer: :html, type: :string }) do |params, bloc|
  html.overflow(params, bloc)
end

new({ method: :gradient, renderer: :html, type: :hash })

new({ method: :remove, renderer: :html, type: :string }) do |object_id_to_remove, bloc|
  if object_id_to_remove.instance_of? Hash
    # case object_id_to_remove[:all]
    # when :color
    #   atome_ids_found = color.dup
    #   atome_ids_found.each do |atome_id|
    #     remove(atome_id)
    #   end
    # when :paint
    #   atome_ids_founds = paint.dup
    #   atome_ids_founds.each do |atome_id|
    #     remove(atome_id)
    #   end
    # when :shadow
    #   atome_id_founds = paint.dup
    #   alert "shadow to remove :#{atome_id_founds}"
    #   atome_id_founds.each do |atome_id|
    #     remove(atome_id)
    #   end
    # end
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
        puts "==> #{atome_to_remove.id} :::#{@id}"
        # we reset background
        html.style(:background, '')
        html.style(:backgroundColor, '')
        @apply.delete(object_id_to_remove)
        apply(@apply)
      end
    when :shadow
      alert "shadow to remove #{object_id_to_remove}\n#{grab(object_id_to_remove).inspect}"
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
