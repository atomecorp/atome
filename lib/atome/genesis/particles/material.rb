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
      # elsif params[:all]
      #   apply.each do |applied_atome|
      #     if  grab(applied_atome).type.to_sym ==  params[:all].to_sym
      #       puts "!go"
      #     end
      #   end
      # puts "so_good #{params}"
      # puts "***> #{apply}"
    end

    params
  else

    params
  end

end
# new({ particle: :remove, category: :property, type: :hash })

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
# new ({ particle: :opacity, category: :material, type: :int })

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
# new({ particle: :border, category: :material, type: :int })
new({ particle: :fill, category: :material, type: :array })

new({ particle: :opacity, category: :material, type: :int })
