class Hash
  def sort_by_array(a)
    Hash[sort_by { |k, _| a.index(k) || length }]
  end
end

# we add the method delete to the NillClass
# because when deleting child
class NilClass
  def delete
  end
end