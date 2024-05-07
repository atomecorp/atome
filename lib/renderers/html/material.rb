# frozen_string_literal: true

new({ method: :overflow, renderer: :html, type: :string }) do |params, bloc|
  html.overflow(params, bloc)
end

new({ method: :gradient, renderer: :html, type: :hash })

# new({ method: :remove, renderer: :html, type: :hash }) do |params|
#   # alert "===> #{params}"
#   # html.table_remove(params)
#   html.remove(params)
# end

new({ method: :remove, renderer: :html, type: :string }) do |object_id_to_remove, bloc|

  if object_id_to_remove.instance_of? Hash
    object_id_to_remove.each do |particle, value|
      case particle
      when :category
        html.remove_class(value)
      else
        if object_id_to_remove[:all]
          atome_ids_found = send(object_id_to_remove[:all])
          atome_ids_found.each do |atome_id|
            remove(atome_id)
          end
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
    when :border
      html.style("border", 'none')
      html.style("filter", 'none')
      @apply.delete(object_id_to_remove)
      # apply(@apply)
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

# new({ method: :border, type: :hash, renderer: :html }) do |value, _user_proc|
#   thickness = value[:thickness] || 5
#   type = value[:pattern] || :solid
#
#   if value[:color].instance_of? Atome
#     color_found = value[:color]
#   else
#     color_found = grab('black_matter').color(value[:color])
#   end
#
#   red = color_found.red * 255
#   green = color_found.green * 255
#   blue = color_found.blue * 255
#   alpha = color_found.alpha
#
#   html.style(:border, "#{type} #{thickness}px rgba(#{red},#{green},#{blue},#{alpha})")
# end
new({ method: :thickness, type: :integer, renderer: :html })

# end
new({ method: :pattern, type: :integer, renderer: :html })

new({ method: :fill, renderer: :html }) do |params|
  html.fill(params)
end

new({ method: :opacity, type: :integer, renderer: :html }) do |value|
  # html.opacity(value)
  html.style('opacity', value)
end

new({ method: :visual, type: :string, renderer: :html, specific: :text }) do |value, _user_proc|
  html.style('fontFamily', value)
end