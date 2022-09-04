module InternalHelpers
  def atomise(property, value)
    # this method create a quark object from atome properties for further processing
    # typically this method is sused to change an object without displaying the vhanges
    unless @monitor.nil? || @monitor == false
      # if the atome is monitored it broadcast the changes
      broadcast(property, value)
    end
    Quark.new(value)
  end

  def properties_common(value, &proc)

    # if display.nil? || display != :none
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
    # else
    #   alert "we have to make it work for \"#{display}\""
    # end

  end

  def update_property(atome, property, value)
    atome.instance_variable_set("@" + property, ATOME.atomise(property.to_sym, value))
  end

  def add_to_instance_variable(instance_name, value)
    value = [value] unless value.instance_of?(Array)
    prev_instance_variable_content = instance_variable_get("@#{instance_name}")
    if prev_instance_variable_content
      if prev_instance_variable_content.q_read.instance_of?(Array)
        value = prev_instance_variable_content.q_read.concat(value)
      else
        prev_instance_variable_content = [prev_instance_variable_content.q_read]
        value = prev_instance_variable_content.concat(value)
      end
    end
    update_property(self, instance_name, value)
  end

  def remove_item_from_hash(object)
    new_list = {}
    object.each do |id_of_atome, content|
        new_list[id_of_atome] = content unless id_of_atome == atome_id
    end
    new_list
  end


  def remove_instance_variable_content(instance_name, value)
    prev_value= instance_variable_get("@#{instance_name}").q_read
    prev_value.delete(value)
    update_property(self, instance_name, prev_value)
  end

  def broadcast(property, value)
    if @monitor[:option]
      proc = @monitor.q_read[:proc]
      monitor_processor({ property: property, value: value, proc: proc })
    end
  end

  def remove_from_parent
    parent&.each do |parent_found|
        new_child_list = []
        if parent_found
          parent_found&.child do |child_found|
            unless child_found.nil?
              new_child_list << child_found.atome_id unless child_found.atome_id == atome_id
            end
          end
        end
        update_property(parent_found, :child, new_child_list)
      end

  end

  def delete_child(option={remove_from_parent: true})
    child.delete(true,option) unless self.child.nil?
  end
end