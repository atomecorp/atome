module InternalHelpers
  def atomise(property, value)
    puts property
    # this method create a quark object from atome properties for further processing
    #if @broadcast
    #  broadcaster(property, value)
    #  #MESSENGER.content[:broadcast]={atome_id => {property => value}}
    #  #monitor({atome_id => {property => value}},"puts 'ok'")
    #  #message={atome_id => {property => value}}
    #  #proc.call(message) if proc.is_a?(Proc)
    #end
    Quark.new(value)
  end

  def broadcaster
    #MESSENGER.content[:broadcast] = {atome_id => {property => value}}
    #MESSENGER.monitor({atome_id => {property => value}})
    #puts MESSENGER.content[:broadcast]
  end

  def broadcast
    # this method just add the @broadcast to indicate if it must broadcast when a property change
    #  @broadcast = atomise(:broadcast, value)
  end


  def monitor( &proc)
    proc.call(MESSENGER.content) if proc.is_a?(Proc)
  end


  def properties_common(value = nil, &proc)
    if proc && (value.instance_of?(String) || value.instance_of?(Symbol))
      property = {}
      property[:proc] = proc
      property[:options] = value
      value = property
    elsif proc && value.instance_of?(Hash)
      value = value.merge(proc: proc)
    elsif proc && (value.instance_of?(Integer) || value.instance_of?(String) || value.instance_of?(Symbol))
      value = {value: value, proc: proc}
    elsif proc
      value = {proc: proc}
    end
    value
  end

  def update_instance_variable(instance_name, value)
    instance_variable_set("@#{instance_name}", instance_name, atomise(instance_name, value))
  end


end