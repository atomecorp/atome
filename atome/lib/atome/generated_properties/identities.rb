module Properties
  def atome_id(value = nil, &proc)
    if value.nil? && !proc
      @atome_id&.read
    else
      value = properties_common(value, &proc)
       atome_id_processor(value)
      atome_id_html(@atome_id)
    end
  end 
 def atome_id=(value, &proc)
  atome_id(value, &proc)
 end

  def id(value = nil, &proc)
    if value.nil? && !proc
      @id&.read
    else
      value = properties_common(value, &proc)
      @id = atomise(value)
      id_html(@id)
    end
  end 
 def id=(value, &proc)
  id(value, &proc)
 end

  def type(value = nil, &proc)
    if value.nil? && !proc
      @type&.read
    else
      value = properties_common(value, &proc)
      @type = atomise(value)
      type_html(@type)
    end
  end 
 def type=(value, &proc)
  type(value, &proc)
 end

  def language(value = nil, &proc)
    if value.nil? && !proc
      @language&.read
    else
      value = properties_common(value, &proc)
      @language = atomise(value)
      language_html(@language)
    end
  end 
 def language=(value, &proc)
  language(value, &proc)
 end

  def private(value = nil, &proc)
    if value.nil? && !proc
      private_getter_processor(value)
      @private&.read
    else
      value = properties_common(value, &proc)
       private_processor(value)
      private_html(@private)
    end
  end 
 def private=(value, &proc)
  private(value, &proc)
 end

  def can(value = nil, &proc)
    if value.nil? && !proc
      can_getter_processor(value)
      @can&.read
    else
      value = properties_common(value, &proc)
       can_processor(value)
      can_html(@can)
    end
  end 
 def can=(value, &proc)
  can(value, &proc)
 end

end
