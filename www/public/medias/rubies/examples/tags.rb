# tags example

t= text"touch me to color all objects that share the tag : my_cool_tag "
b = box({ size: 66 , y: 33})
b.tag("my_tag")
c = circle({ x: 200, y: 33 })
batch([b,c, t]).tag('my_cool_tag')
c2=circle({x: 200, y: 96, color: :green, tag: :other_tag})

b.add({ tag: :new_tag })

t.touch do
  find({ tag: "my_cool_tag" }).color(:yellow)
  t.content("the box have the tags : #{b.tag}, \nthe green circle has the tag :#{c2.tag} ")
end

