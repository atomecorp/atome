module AtomeHelpers
  def delete(params = nil)
    if Atome.atomes.key?(atome_id)
      # we remove the atome fom the Atome.atomes's hash
      delete_atome = Atome.atomes.delete(atome_id)
      unless child.nil?
        #the the current atome habve child we delete them too
        # We will remove any reference of this atome from its parents
        parent_child = grab(parent.read).child.read
        updated_child_list = []
        parent_child.each do |child_found|
          if child_found != atome_id
            updated_child_list << child_found
          end
        end
        child.delete(true)
        grab(parent.read).instance_variable_set("@child", atomise(:child, updated_child_list))
      end
      # adding the deleted atome to the black_hole for later retrieve
      grab(:black_hole).content[atome_id] = delete_atome
      # now we remove the atome from view if it is rendered
      unless delete_atome.render == false
        delete_html
      end
    end
  end

  def properties(params = nil)
    if params || params == false
      error("info is read only!! for now")
    else
      properties = {}
      instance_variables.map do |attribute|
        if instance_variable_get(attribute).nil?
          properties[attribute.sub("@".to_sym, "")] = nil
        else
          properties[attribute.sub("@".to_sym, "")] = instance_variable_get(attribute).read
        end
      end
      properties
    end
  end

  def inspect
    properties
  end

  def play(options, &proc)
    play_html(options, &proc)
  end

  def transmit(values)
    case values.keys[0]
    when :midi
      if values[:midi].instance_of?(Hash)
        msg = values[:midi].keys[0]
      else
        msg = values[:midi]
      end
      case msg
      when :play
        note = values[:midi][:play].delete(:note)
        channel = values[:midi][:play].delete(:channel)
        options = values[:midi][:play]
        midi_play(note, channel, options)
      when :stop
        note = values[:midi][:stop].delete(:note)
        channel = values[:midi][:stop].delete(:channel)
        options = values[:midi][:stop]
        midi_stop(note, channel, options)
      when :inputs
        midi_inputs
      when :outputs
        midi_outputs
      else
        values
      end
    when :beaglebone
      # bbb communication layer
    when :shell
      alert values[:shell]
    else
      value
    end
  end

  def remote(msg)
    remote_server(msg)
  end

  def shell(command)
    remote({type: :command, message: command})
  end

end