#code example

text(content: "the code within ies executed, it'll create a green circle, touch the red circle ",code: "c=circle;c.color(:green)\nc.x(66)\nc.y(66)")
cell({ content: "box()", exec: false,atome_id: :the_box })
cell({ content: "c=circle({x:300, y: 300});c.touch do \n grab(:the_box).exec(true)\nend" })

# use for code  type (machine molecule )