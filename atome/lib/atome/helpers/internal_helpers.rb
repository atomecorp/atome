module InternalHelpers
  def atomise(property, value)
    # this method create a quark object from atome properties for further processing
    # typically this method is used to change an object without displaying the changes
    unless @monitor.nil? || @monitor == false
      # if the atome is monitored it broadcast the changes
      broadcast(property, value)
    end
    Quark.new(value)
  end

  def send_to_render_engine( property, value, password)
    # below the condition allow to get the value from corresponding property in the atome found
    # puts "renderer : #{renderer}"
    $default_renderer.each do |render_engines|
      value = value.send(property) if value.instance_of?(Atome)
      case render_engines
      when :html
        send("#{property}_html", value, password)
      when :fabric
        send("#{property}_html", value, password)
        send("#{property}_fabric", value, password)
      when :headless
        send("#{property}_headless", value, password)
      when :speech
        send("#{property}_speech", value, password)
      when :three
        send("#{property}_three", value, password)
      when :zim
        send("#{property}_zim", value, password)
      else
        send("#{property}_html", value, password)
      end
    end

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
    prev_value = instance_variable_get("@#{instance_name}").q_read
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

  def delete_child(option = { remove_from_parent: true })
    child.delete(true, option) unless self.child.nil?
  end
end