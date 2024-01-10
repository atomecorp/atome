# frozen_string_literal: true

new({ particle: :width })
new({ particle: :height })
new({ particle: :size }) do |params|
  params
end

new({ particle: :size }) do |params|
  params = { value: params } unless params.instance_of? Hash
  params[:recursive] ||= false
  params[:reference] ||= :x
  params[:target] ||= :self # :all resize atome + attached +distance between  to the value
  # self: resize the current atome to current value
  params[:propagate] ||= :raw # proportional atome children will be resize according
  # to its parent , raw apply the raw value to the attached atomes
  if params[:reference] == :x
    original_width = width
    width(params[:value])
    height(height * params[:value] / original_width)
    ratio = width / original_width
  else
    original_height = height
    height(params[:value])
    width(width * params[:value] / original_height)
    ratio = height / original_height

  end

  if params[:recursive]
    if params[:target] == :all
      # most complex case will resize everything
    elsif params[:propagate] == :raw
      attached.each do |atome_id|
        grab(atome_id).size(params[:value])
      end
    else

      attached.each do |atome_id|
        attached_atome = grab(atome_id)
        new_value = if params[:reference] == :x
                      attached_atome.width * ratio
                    else
                      attached_atome.height * ratio
                    end
        params[:value] = new_value
        attached_atome.size(params)
      end
    end

  end

end
