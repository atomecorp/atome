# group example

t = text({ content: "Click to add the yellowgreen circle to the group so it'll be blurred and draggable", atome_id: :the_text })
image({content: :boat, x:666,atome_id: :pix_1,})
image({content: :moto, y:333, atome_id: :pix_2})
b = box({ size: 66, y: 33, color: :red, atome_id: :tutu })
b.tag({ content: "my_tag" })
circle({ x: 96, y: 33,  atome_id: :first_circle })
c2=circle({ x: 333, y: 96, color: :green, tag: :other_tag,atome_id: :the_circle  })
b.add({ tag: :new_tag })
circle({  atome_id: :the_second_circle , color: :yellowgreen, x: 96, y: 96})
# b2=box({size: 66, x: 66, y: 66})
# b2.text({content: "i am red!!", color: :red})
# the group is both static ( content send) and based on a search (condition) and dynamic any atome matching will be tretaed!
g=group({ content: [:pix_1, :pix_2], name: :my_group, treatment: {blur: 3, width: 33, drag: true}, dynamic: true, condition: { color: :red }, atome_id: :the_group })

t.touch do
  c2.color(:red)
end

g.treatment(color: :orange)