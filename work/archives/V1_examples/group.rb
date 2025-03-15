# group example

t = text({ content: "Make the yellowgreen circle red to check if it'll be added to the group and treated!!", atome_id: :the_text })
image({ content: :boat, x: 666, atome_id: :pix_1, })
image({ content: :moto, y: 333, atome_id: :pix_2 })
b = box({ size: 66, y: 33, color: :red, atome_id: :b_box_id })
b.tag({ content: "my_tag" })
circle({ x: 96, y: 33, atome_id: :first_circle })
c2 = circle({ x: 333, y: 96, color: :green, tag: :other_tag, atome_id: :the_circle })
b.add({ tag: :new_tag })
circle({ atome_id: :the_second_circle, color: :yellowgreen, x: 96, y: 96 })
# b2=box({size: 66, x: 66, y: 66})
# b2.text({content: "i am red!!", color: :red})
# the group is both static ( content send) and based on a search (condition) and dynamic any atome matching will be tretaed!
group({ content: [:pix_1, :pix_2], name: :my_group, treatment: { blur: 3, width: 33 }, dynamic: true, condition: { color: :red }, atome_id: :the_group })

t.touch do
  c2.color(:red)
end
