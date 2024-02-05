# frozen_string_literal: true

new({ particle: :width, category: :geometry, type: :int })
new({ particle: :height, category: :geometry, type: :int })

new({ particle: :size, category: :geometry, type: :int }) do |params|
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
  else
    original_height = height
    height(params[:value])
    width(width * params[:value] / original_height)
  end

  if params[:recursive]
    attached.each do |atome_id|
      grab(atome_id).size(params)
    end

  end

end
