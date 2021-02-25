module HierarchiesProperties
  def parent=(value)
    @parent = atomise(value)
    parent_html(@parent)
  end

  def parent
    @parent&.read
  end
end