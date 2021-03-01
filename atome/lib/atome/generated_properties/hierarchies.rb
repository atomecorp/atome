module Properties

  def force_instance_variable instance, value
    instance=value
  end
  def parent(value = nil, &proc)
    if value.nil? && !proc
      @parent&.read
    else
      value = properties_common(value, &proc)
      @parent = atomise(value)
      #alert grab(value.to_sym).class
      #grab(value).force_instance_variable(@child, self.atome_id)
      #@child =atomise(self.atome_id)
      parent_html(@parent)
    end
  end 
 def parent=(value, &proc)
  parent(value, &proc)
 end

  def child(value = nil, &proc)
    if value.nil? && !proc
      @child&.read
    else
      value = properties_common(value, &proc)
      @parent = atomise(self.atome_id)
      @child = atomise(value)
      child_html(@child)
    end
  end 
 def child=(value, &proc)
  child(value, &proc)
 end

  def insert(value = nil, &proc)
    if value.nil? && !proc
      @insert&.read
    else
      value = properties_common(value, &proc)
      @insert = atomise(value)
      insert_html(@insert)
    end
  end 
 def insert=(value, &proc)
  insert(value, &proc)
 end

end
