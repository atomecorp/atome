module HierarchiesProperties
  def parent=(value)
    @parent = atomise(value)
  end

  def parent
    @parent.read
  end
end