module Properties
  def parent(value = nil, &proc)
    if value.nil? && !proc
      parent_getter_processor(value)
    else
      value = properties_common(value, &proc)
      parent_pre_processor(value)
      self
    end
  end 
 def parent=(value, &proc)
  parent(value, &proc)
 end

  def child(value = nil, &proc)
    if value.nil? && !proc
      child_getter_processor(value)
    else
      value = properties_common(value, &proc)
      child_pre_processor(value)
      self
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
      @insert = atomise(:insert,value)
      insert_html(@insert)
      self
    end
  end 
 def insert=(value, &proc)
  insert(value, &proc)
 end

end
