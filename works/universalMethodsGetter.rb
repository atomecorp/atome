module Properties
  def x(value = nil, &proc)
    if value.nil? && !proc
      #@x&.read
      self
    else
      if value.instance_of?(Atome)
        value = value.instance_variable_get("@x").read
      end
      value = properties_common(value, &proc)
      @x = atomise(:x, value)
      x_html(@x)
    end
  end

  def x=(value, &proc)
    x(value, &proc)
  end
end