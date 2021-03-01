module HierarchiesProperties
  def parent(value = nil, &proc)
    if value.nil? && !proc
      @parent&.read
    else
      value = properties_common(value, &proc)
      @parent = atomise(value)
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
