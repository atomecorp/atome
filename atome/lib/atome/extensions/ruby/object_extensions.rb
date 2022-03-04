class Hash
  def sort_by_array(a)
    Hash[sort_by { |k, _| a.index(k) || length }]
  end
end

