#restore atome

b=box({atome_id: :my_atome,color: :green, x: 200, y: 100})
atome_props= b.properties
ATOME.wait 1 do
  b.delete(true)
end
ATOME.wait 2 do
  Atome.new(atome_props)
end

