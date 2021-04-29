# extract example

c=circle({atome_id: :the_circle})
c.text({ content: "children are restored too!!" , size: 22})
c.touch do
  grab(:view).extract(c.atome_id)
  ATOME.wait 2 do
    grab(:intuition).insert(c.atome_id)
  end
  c.touch do
    c.delete
  end
end
b=box({x: 666, drag: true, atome_id: :the_box})
t=b.text({ content: :ok , yy: 3, color: :black})
i=image({content: :atome, size: 33, x: 96})
#
i.transfer(b.atome_id)
t.content ("logo parent is #{i.parent}")