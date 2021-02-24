module AtomeUtilities
  def atomise(properties)
    # this method create a quark object from atome properties for further processing
    Quark.new(properties)
  end

  def reorder_properties(properties)
    # we re-order the hash to puts the atome_id type at the begining to optimise rendering
    order_wanted = [:atome_id, :type, :parent, :width, :height, :x, :y, :z, :center, :size, :content]
    properties.sort_by_array(order_wanted)
  end

  def centering(values)
    puts values
  end

  def resize
  end

  def resize_actions(params = nil)
    if params
      params.each do |key, value|
        grab(:actions).resize_actions[key] = value
      end
    elsif atome_id[:value] == :actions
      if @resize_actions.instance_of?(NilClass)
        @resize_actions = {}
      else
        @resize_actions
      end
    else
      grab(:actions).resize_actions
    end
  end

  def viewer_actions
    grab(:view).resize do
      grab(:actions).resize_actions[:center]&.each do |atome|
        atome.centering(:x, atome.x[:center], atome.x[:reference], atome.x[:dynamic]) if atome.x[:center]
        atome.centering(:y, atome.y[:center], atome.y[:reference], atome.y[:dynamic]) if atome.y[:center]
      end
    end
  end
end