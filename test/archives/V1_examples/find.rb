# find example

t = text "touch me to blur all orange object"
t2 = text({ content: "touch me to resize all object of the type shape ", x: 390 })

b = box({ size: 66, y: 33, x: 333, color: :orange })
b.tag("my_tag")
circle({ x: 200, y: 33, color: :orange })
circle({ x: 200, y: 96, color: :green, tag: :other_tag })

b.add({ tag: :new_tag })

t.touch do
  grab(:view).find({ color: :orange }).blur(3)
end

t2.touch do
  grab(:view).find({ type: :shape }).size(33)
end

# enhanced find demo
b = box({ color: :red, atome_id: :the_box, y: 44 })
circle({ y: 500, atome_id: :the_circle, color: :green, x: 99 })
t = b.text({ content: "my super text!", y: 50, color: :green, atome_id: :text_1 })
t.text({ x: 222, content: :super, atome_id: :text_child, color: :orange })
b.image({ content: :boat, size: 33, atome_id: :the_image, y: 500 })
# grab(:view).find({ y: 500,  condition: :or, recursive: true }).find({ color: :green}).blur(6)
# find({ y: 500, color: :green, recursive: true, condition: :or }).blur(9)
grab(:view).find({ y: 50, color: :green, condition: :and, recursive: 3 }).blur(3)
# grab(:view).find({x: 222, recursive: 3 }).blur(7)
# b.find({color: :green, recursive: true }).blur(7)
# grab(:view).find({ color: :red, y: 32 }).find({y: 500}).blur(6)

# condition: or(mean at least one  condition must be respected),  and(mean both condition must be respected)
# recursive: true, 1, 2 (max depth of recursivity)
# find can be chained