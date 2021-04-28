# Working on group

ATOME.program(Time.now)


box(x: 333)
container({ atome_id: :toto })

t= text"touch me to blur all red object "
t2= text({content: "touch me to resize all object of the type shape ", y:16})

b = box({ size: 66 , y: 33, color: :red})
b.tag("my_tag")
circle({ x: 200, y: 33 })
circle({x: 200, y: 96, color: :green, tag: :other_tag})

b.add({ tag: :new_tag })

# t.touch do
#   find({ color: :red }).blur(3)
# end
#
# t2.touch do
#   find({ type: :shape }).size(33)
# end

a= group({content: [:poil, :poilu], name: :my_group, dynamic: true, condition: { color: :red }})
alert a.inspect
s=shape({content: :atome})
alert (s.inspect)
