module AtomeHelpers
  def remove_item_from_hash(object)
    new_list = {}
    object.each do |id_of_atome, content|
      unless id_of_atome == atome_id
        new_list[id_of_atome] = content
      end
    end
    new_list
  end

  def delete_from_parent
    self.parent do |parent_found|
      new_child_list = []
      parent_found.child do |child_found|
        unless child_found.atome_id == atome_id
          new_child_list << child_found.atome_id
        end
      end
      update_property(parent_found, :child, new_child_list)

    end
  end

  def delete_child
    unless self.child.nil?
      self.child.delete
    end
  end

  def delete
    delete_from_parent
    delete_child
    Atome.atomes = remove_item_from_hash(Atome.atomes)
    grab(:black_hole).content[atome_id] = self
    delete_html
  end

  def duplicate(value)
    value = { x: 0, y: 0, offset: { x: 6, y: 6 } }.merge(value)
    (0..value[:y]).each do |y_val|
      (1..value[:x]).each do |x_val|

        atome_property = self.inspect.merge({ atome_id: self.atome_id.to_s + x_val.to_s,
                                              x: self.x + self.width * x_val + value[:offset][:x] * x_val,
                                              y: self.width * y_val + value[:offset][:y] * y_val })
        atome_property[:monitor] = :poil
        Atome.new(atome_property)
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
      text("shell value from atome_helpers.rb line 97 : #{values[:shell]}")
    else
      value
    end
  end

  AtomeHelpers.class_variable_set("@@web_socket", WebSocket.new("5.196.69.103:9292"))

  def message(data)
    AtomeHelpers.class_variable_get("@@web_socket").send(data)
  end

  def shell(command)
    AtomeHelpers.class_variable_get("@@web_socket").send({ type: :command, message: command })
  end

  def fixed(value)
    fixed_html(value)
  end

  # def find(query)
  #   alert "poil"
  #   child
  # end

  def eden_search(query)
    #fixme Universe will be a db that contain users user's media and so on, for now Universe only hold default medias
    case query[:type]
    when :image
      Universe.images[query[:name]]
    when :video
      Universe.videos[query[:name]]
    when :audio
      Universe.audios[query[:name]]
    else
      query
    end
  end

  def find(query)
    unless query[:scope]
      query[:scope] = :current
    end
    case query[:scope]
    when :eden
      eden_search(query)
    when :current
      child
    else
      "a look at eDen"
    end
  end

end