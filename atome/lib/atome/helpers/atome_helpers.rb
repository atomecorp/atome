module AtomeHelpers
  #def delete
  #  if Atome.atomes.key?(atome_id)
  #    # we remove the atome fom the Atome.atomes's hash
  #    # delete_atome = Atome.atomes.delete(atome_id)
  #          delete_atome = grab(atome_id)
  #    new_atomes_list={}
  #    verif=[]
  #    Atome.atomes.each do |id_of_atome, content|
  #      unless id_of_atome == atome_id
  #        new_atomes_list[id_of_atome] =content
  #        verif << id_of_atome
  #      end
  #    end
  #    Atome.atomes=new_atomes_list
  #    # alert "#{verif}"
  #    ###############################
  #    second_test=[]
  #    Atome.atomes.each do |id_of_atome, content|
  #      unless id_of_atome == atome_id
  #        second_test << id_of_atome
  #      end
  #    end
  #    # alert second_test
  #    ##############################
  #    unless child.nil?
  #      #the the current atome have child we delete them too
  #      # We remove any reference of this atome from its parents
  #      parent_child = []
  #      parent.read.each do |parent_found|
  #        parent_child << grab(parent_found).child.read
  #      end
  #      updated_child_list = []
  #      parent_child.each do |child_found|
  #        if child_found != atome_id
  #          updated_child_list << child_found
  #        end
  #      end
  #      # child.delete(true)
  #      # grab(parent.read).instance_variable_set("@child", atomise(:child, updated_child_list))
  #    end
  #
  #    # adding the deleted atome to the black_hole for later retrieve
  #    grab(:black_hole).content[atome_id] = delete_atome
  #    # now we remove the atome from view if it is rendered
  #    unless delete_atome.render == false
  #      # delete_html
  #      the_parent = grab(parent.read)
  #      if the_parent
  #        children_found = the_parent.child.read
  #        new_child_list = []
  #        children_found.each do |child|
  #          unless child == self.atome_id
  #            new_child_list << child
  #          end
  #        end
  #        the_parent.instance_variable_set("@child", atomise(:child, new_child_list))
  #      end
  #    end
  #  end
  #end

  def remove_item_atomes
    alert Atome.atomes # remove current item from list
  end

  def detach_child
    alert self.parent # for each remove current child
  end

  def delete_child
    alert self.child # delete
  end

  def add_to_black_hole
    alert grab(:black_hole).content # add current deleted item
  end

  def delete
    remove_item_atomes
    detach_child
    delete_child
    add_to_black_hole
    delete_html
  end

  def duplicate(value)
    value = { x: 0, y: 0, offset: { x: 6, y: 6 } }.merge(value)
    (0..value[:y]).each do |y_val|
      (1..value[:x]).each do |x_val|
        atome_property = self.inspect.merge({ atome_id: self.atome_id.to_s + x_val.to_s, x: self.x + self.width * x_val + value[:offset][:x] * x_val, y: self.width * y_val + value[:offset][:y] * y_val })
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

  def remote(msg)
    remote_server(msg)
  end

  def shell(command)
    remote({ type: :command, message: command })
  end

end