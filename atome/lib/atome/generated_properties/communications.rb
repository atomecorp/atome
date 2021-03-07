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

end
