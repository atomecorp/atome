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
    unless value.instance_of?(Array)
      value=[value]
    end
    prev_instance_variable_content=instance_variable_get("@#{instance_name}")
    if prev_instance_variable_content
      if prev_instance_variable_content.read.instance_of?(Array)
        value=prev_instance_variable_content.read.concat(value)
      else
        prev_instance_variable_content=[prev_instance_variable_content.read]
        value=prev_instance_variable_content.concat(value)
      end
    end
    instance_variable_set("@#{instance_name}", atomise(instance_name, value))
  end

  #def update_instance_variable(instance_name, value)
  #  unless value.instance_of?(Array)
  #    value=[value]
  #  end
  #  alert instance_variable_get("@#{instance_name}").read
  #  #prev_instance_variable_content=instance_variable_get("@#{instance_name}").read
  #  #alert prev_instance_variable_content
  #  #if prev_instance_variable_content
  #  #  if prev_instance_variable_content.read.instance_of?(Array)
  #  #    value=prev_instance_variable_content.read.concat(value)
  #  #  else
  #  #    alert prev_instance_variable_content.read
  #  #    prev_instance_variable_content=[prev_instance_variable_content.read]
  #  #    value=prev_instance_variable_content.concat(value)
  #  #  end
  #  #end
  #  #if prev_instance_variable_content.defined?
  #  #  alert prev_instance_variable_content.class
  #  #  #instance_variable_set("@#{instance_name}", atomise(instance_name, value))
  #  #else
  #  #  instance_variable_set("@#{instance_name}", atomise(instance_name, value))
  #  #
  #  #end
  #end
end