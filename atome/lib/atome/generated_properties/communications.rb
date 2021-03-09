module Properties
  def share(value = nil, &proc)
    if value.nil? && !proc
      @share&.read
    else
      value = properties_common(value, &proc)
      @share = atomise(:share,value)
      share_html(@share)
      self
    end
  end 
 def share=(value, &proc)
  share(value, &proc)
 end

  def transmit(value = nil, &proc)
    if value.nil? && !proc
      @transmit&.read
    else
      value = properties_common(value, &proc)
      @transmit = atomise(:transmit,value)
      transmit_processor(value)
      self
    end
  end 
 def transmit=(value, &proc)
  transmit(value, &proc)
 end

  def receive(value = nil, &proc)
    if value.nil? && !proc
      @receive&.read
    else
      value = properties_common(value, &proc)
      @receive = atomise(:receive,value)
      self
    end
  end 
 def receive=(value, &proc)
  receive(value, &proc)
 end

end
