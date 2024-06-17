# frozen_string_literal: true

new({ particle: :component, category: :material, type: :string })

new({ particle: :edit, category: :material, type: :boolean })
new({ particle: :style, category: :material, type: :string })
new({ pre: :style }) do |styles_send, _user_proc|
  styles_send.each do |particle_send, value|
    send(particle_send, value)
  end
end
new({ particle: :hide, category: :material, type: :boolean })

new({ particle: :remove, category: :property, type: :hash }) do |params|

  if params.instance_of? Hash
    if params[:row]
      data.delete_at(params[:row])
    elsif params[:column]
      column = params[:column]
      data.map do |hash|
        hash.delete(hash.keys[column]) if hash.keys[column]
      end
    end

    params
  else

    params
  end

end

new({ post: :remove }) do |params|
  # TODO : we have to rethink the removal of atome and particles (with exception like category) and maybe 'use particle type' to handle removal
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
    when :shadow
      shadow.each do |atome_id_found|
        @apply.delete(atome_id_found)
      end
    when :border
      border.each do |atome_id_found|
        @apply.delete(atome_id_found)
      end
    else
      params.each do |particle, value|
        case particle
        when :category
          @category.delete(value) if particle == :category
        else
          puts 'write code to remove atome applied'
        end
      end

    end
  else
    # the systems send an id we have to remove it from parent too
    grab(params).fasten.delete(id)
    grab(params).affect.delete(id)
  end
  params
end

new({ particle: :classes, category: :material, type: :json }) do |value|
  Universe.classes[value] ||= []
  Universe.classes[value] |= [id]
end
new({ particle: :remove_classes, category: :material, type: :boolean }) do |value|
  Universe.classes[value].delete(id)
end

# vector shape
new({ particle: :definition, category: :material, type: :string })

new({ sanitizer: :definition }) do |params|
  # we remove the unwanted svg tags
  params = params.gsub(/<svg[^>]*>|<\/svg>/, '')
  params
end

new({ particle: :gradient, category: :material, type: :int })

new({ particle: :thickness, category: :material, type: :int })
new({ after: :thickness }) do |params|
  a = affect.dup #  FIXME  we have to dup else some items in the array array other duplicated
  a.each do |atome_to_refresh|
    grab(atome_to_refresh).apply(id)
  end
  params
end
new({ particle: :pattern, category: :material, type: :string })
new({ after: :pattern }) do |params|
  a = affect.dup #  FIXME  we have to dup else some items in the array array other duplicated
  a.each do |atome_to_refresh|
    grab(atome_to_refresh).apply(id)
  end
  params
end
new({ particle: :fill, category: :material, type: :array })

new({ particle: :opacity, category: :material, type: :int })

new({ particle: :exchange }) do |params, &bloc|
  params.each_key do |part_f|
    part_to_remove = send(part_f)
    if part_to_remove.instance_of?(Array)
      part_to_remove.each do |part_to_r|
        remove(part_to_r)
      end
    end
    set(params)
  end
end
