class Hash
  def sort_by_array(a)
    Hash[sort_by { |k, _| a.index(k) || length }]
  end
end


class NilClass

  #fixme ugly patch to resolve error when deleting child : try insert example then click next ...
  def delete
  end
  #fixme second ugly patch to resolve error when testing extract methods : test extract example
  def parent

  end
end