module InternalHelpers
  def atomise(property, value)
    # this method create a quark object from atome properties for further processing
    if @broadcast
      broadcaster(property, value)
      #MESSENGER.content[:broadcast]={atome_id => {property => value}}
      #monitor({atome_id => {property => value}},"puts 'ok'")
      #message={atome_id => {property => value}}
      #proc.call(message) if proc.is_a?(Proc)
    end
    Quark.new(value)
  end

  def broadcaster (property, value)
    MESSENGER.content[:broadcast] = {atome_id => {property => value}}
    #puts MESSENGER.content[:broadcast]
  end

  def broadcast(value)
    # this method just add the @broadcast to indicate if it must broadcast when a property change
    @broadcast = value
  end


  def monitor(options, &proc)
    options
    proc.call(MESSENGER.content) if proc.is_a?(Proc)
  end

  def reorder_properties(properties)
    # we re-order the hash to puts the atome_id type at the begining to optimise rendering
    order_wanted = [:atome_id, :type, :parent, :width, :height, :x, :y, :z, :center, :size, :content]
    properties.sort_by_array(order_wanted)
  end

  def centering(values)
    "todo add centering#{values}"
  end

  #def resize
  #end
  #
  #def resize_actions(params = nil)
  #  if params
  #    params.each do |key, value|
  #      grab(:actions).resize_actions[key] = value
  #    end
  #  elsif atome_id[:value] == :actions
  #    if @resize_actions.instance_of?(NilClass)
  #      @resize_actions = {}
  #    else
  #      @resize_actions
  #    end
  #  else
  #    grab(:actions).resize_actions
  #  end
  #end

  #def viewer_actions
  #  grab(:view).resize do
  #    grab(:actions).resize_actions[:center]&.each do |atome|
  #      atome.centering(:x, atome.x[:center], atome.x[:reference], atome.x[:dynamic]) if atome.x[:center]
  #      atome.centering(:y, atome.y[:center], atome.y[:reference], atome.y[:dynamic]) if atome.y[:center]
  #    end
  #  end
  #end

  def properties_common(value = nil, &proc)
    if proc && (value.instance_of?(String) || value.instance_of?(Symbol))
      property = {}
      property[:value] = proc
      property[:options] = value
      value = property
    elsif proc && value.instance_of?(Hash)
      value = value.merge(value: proc)
    elsif proc
      value = {value: proc}
    end
    value
  end

  def update_instance_variable(instance_name, value)
    instance_variable_set("@#{instance_name}", instance_name, atomise(instance_name, value))
  end


end