# frozen_string_literal: true
class Atome
  def fit(params)
    target_size = params[:value]
    axis = params[:axis]
    objet_atome= self
    # Calculez la taille totale et déterminez le facteur de redimensionnement
    total_size, max_other_axis_size = calculate_total_size(objet_atome, axis)
    scale_factor = target_size.to_f / total_size

    # Appliquez le redimensionnement et le repositionnement
    resize_and_reposition(objet_atome, scale_factor, axis, max_other_axis_size)
  end
  def calculate_total_size(objet_atome, axis)
    total_size = (axis == :x) ? objet_atome.width : objet_atome.height
    max_other_axis_size = (axis == :x) ? objet_atome.height : objet_atome.width

    objet_atome.attached.each do |child_id|
      child = grab(child_id)
      child_size = (axis == :x) ? child.width : child.height
      other_axis_size = (axis == :x) ? child.height : child.width

      total_size += child_size
      max_other_axis_size = [max_other_axis_size, other_axis_size].max
    end

    [total_size, max_other_axis_size]
  end
  def resize_and_reposition(objet_atome, scale_factor, axis, max_other_axis_size)
    current_position = 0
    # Redimensionnez et repositionnez l'objet principal
    resize_object(objet_atome, scale_factor, axis, max_other_axis_size)
    current_position += (axis == :x) ? objet_atome.width : objet_atome.height

    # Redimensionnez et repositionnez chaque enfant
    objet_atome.attached.each do |child_id|
      child = grab(child_id)
      resize_object(child, scale_factor, axis, max_other_axis_size)

      if axis == :x
        child.left(current_position)
        child.top((max_other_axis_size - child.height) / 2)
        current_position += child.width
      else
        child.top(current_position)
        child.left((max_other_axis_size - child.width) / 2)
        current_position += child.height
      end
    end
  end
  def resize_object(objet, scale_factor, axis, max_other_axis_size)
    if axis == :x
      new_width = objet.width * scale_factor
      new_height = new_width / (objet.width.to_f  / objet.height)
      objet.width(new_width)
      objet.height([new_height, max_other_axis_size].min)
    else
      new_height = objet.height * scale_factor
      new_width = new_height / (objet.height.to_f  / objet.width)
      objet.height(new_height)
      objet.width([new_width, max_other_axis_size].min)
    end
  end
end

# # Utilisation de la méthode
# c.fit({value: 200, axis: :x})

c=circle({height: 333, width: 100})
b=c.box({left: 155, width: 250, height: 100, id: :my_box})
b.circle({color: :yellow, width: 55, height: 88})

wait 2 do
  c.fit({value: 200, axis: :x})
end



# wait 1 do
#   c.size(33)
#   wait 1 do
#     c.size({value:  50, recursive: true, reference: :y })
#     wait 1 do
#       c.size({value:  200, recursive: true, reference: :x,propagate:  :proportional })
#
#     end
#   end
# end

# alert c.size
# t=text(({data: :hallo, component: {size: 190}}))


