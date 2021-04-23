# find example

b = box(size: 66)
b.tag("my_tag")
c = circle(x: 200)
circle({x: 200, y: 66, color: :green, tag: :other_one})
t = text({ content: "click the box", y: 66 })
batch([b,c, t]).tag('my_cool_tag')

find({ tag: "my_cool_tag" }).color(:yellow)
b.add({ tag: :new_tag })
b.touch do
  t.content("my tags are #{b.tag}")
end
