module HierarchiesProperties
  def parent=(value)
    @parent = Quark.new(value)
  end

  def parent
    @parent.read
  end
end