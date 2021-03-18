#restore atome

b=box({atome_id: :my_atome,color: :green, x: 200, y: 100})
atome_props= b.properties
b.delete(true)
Atome.new(atome_props)
