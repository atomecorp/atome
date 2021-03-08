module InternalHelpers
  def atomise(property, value)
    # this method create a quark object from atome properties for further processing
    unless @monitor.nil? || @monitor == false
      # if the atome is monitored it broadcast the changes
      broadcast(property, value)
    end
    Quark.new(value)
  end

  def properties_common(value, &proc)
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

  def add_to_instance_variable(instance_name, value)
    unless value.instance_of?(Array)
      value = [value]
    end
    prev_instance_variable_content = instance_variable_get("@#{instance_name}")
    if prev_instance_variable_content
      if prev_instance_variable_content.read.instance_of?(Array)
        value = prev_instance_variable_content.read.concat(value)
      else
        prev_instance_variable_content = [prev_instance_variable_content.read]
        value = prev_instance_variable_content.concat(value)
      end
    end
    instance_variable_set("@#{instance_name}", atomise(instance_name, value))
  end

  def broadcast(property, value)
    proc= @monitor.read[:proc]
    monitor_processor({property: property,value: value,proc: proc})
  end
end