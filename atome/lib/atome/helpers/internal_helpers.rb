module InternalHelpers
  def atomise(property, value)
    # this method create a quark object from atome properties for further processing
    unless @monitor.nil? || @monitor == false
      # if the atome is monitored it broadcast the changes
      broadcast(property, value)
    end
    Quark.new(value)
  end

  def update_property(atome, property, value)
    atome.instance_variable_set("@" + property, ATOME.atomise(property.to_sym, value))
  end

  def properties_common(value, &proc)
    formatted_value=value
    if proc && (value.instance_of?(String) || value.instance_of?(Symbol))
      property = {}
      property[:proc] = proc
      property[:options] = value
      formatted_value = property
    elsif proc && value.instance_of?(Hash)
      formatted_value = value.merge(proc: proc)
    elsif proc && (value.instance_of?(Integer) || value.instance_of?(String) || value.instance_of?(Symbol))
      formatted_value = { value: value, proc: proc }
    elsif proc
      formatted_value = { proc: proc }
    end
    formatted_value
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
    update_property(self, instance_name, value)
  end

  def broadcast(property, value)
    proc = @monitor.read[:proc]
    monitor_processor({ property: property, value: value, proc: proc })
  end
end