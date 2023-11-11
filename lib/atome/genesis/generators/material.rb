# frozen_string_literal: true

new({ particle: :component })

new({ particle: :edit })
new({ particle: :style })
new({ pre: :style }) do |styles_send, _user_proc|
  styles_send.each do |particle_send, value|
    send(particle_send, value)
  end
end
new({ particle: :hide })

new({ particle: :remove })

new({post: :remove}) do |params|

  if params.instance_of?(Hash)
    case params[:all]
    when :color
      color.each do |atome_id_found|
        @apply.delete(atome_id_found)
      end
    when :paint
      paint.each do |atome_id_found|
        @apply.delete(atome_id_found)
      end
    # when :shadow
    #   alert :remove_shade
    else
      puts 'write code'
    end
  else
    #   object_to_remove = grab(object_id_to_remove)
    #   @apply.delete(object_id_to_remove)
    #   @attached.delete(object_id_to_remove)
    #   # we remove the id  from all atomes binding associated methods :  (attached, affect)
    #   object_to_remove.instance_variable_get("@attached").delete(id)
    #   object_to_remove.instance_variable_get("@affect").delete(id)
    #
  end
  # object_id_to_remove

  # case object_to_remove
  # when :color
  #   send(object_to_remove, :black)
  # when :shadow
  #   # TODO : code to write
  #   puts 'code to write'
  # else
  #   # object_to_remove_decision(object_to_remove)
  # end
   params
end

new({ particle: :classes }) do |value|
  Universe.classes[value] ||= []
  Universe.classes[value] |= [id]
end
new({ particle: :remove_classes }) do |value|
  Universe.classes[value].delete(id)
end
new ({ particle: :opacity })

# vector shape
new({ particle: :definition })

new({ sanitizer: :definition }) do |params|
  # we remove the unwanted svg tags
  params = params.gsub(/<svg[^>]*>|<\/svg>/, '')
  params
end

new({ particle: :gradient })
