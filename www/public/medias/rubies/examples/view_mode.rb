# view mode example

a = image({ content: :moto, atome_id: :the_moto, x: 96, y: 333})
t1=text({ content: "list mode(childs)", x: 3,y: 3})
t2=text({ content: "list property", x: 3,y: 33 })
t3=text({ content: "natural mode" , x: 3,y: 66})

t1.touch do
  a.render({
             mode: :list,
             ordered: :x,
             visualize: [:visual,:x, :y, :color, :atome_id]
           })
end
t2.touch do
  a.render({
             mode: :list,
             list: :property,
             sort: :alphabetically
           })
end
t3.touch do
  a.render(true)
end

a.drag(true)
a.circle({ color: :green, x: 39, y:33, atome_id: :the_circle })
a.text({ content: :kool, color: :yellow, x: 0, y:96, atome_id: :the_text})
a.box({width: 33, height: 69, x: 36, atome_id: :the_box})

toto=text({ content: :hhhh , x: 333})
titi=toto.text({ content: :daco , x: 399})