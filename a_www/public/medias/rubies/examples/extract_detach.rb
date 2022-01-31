# extract example

c = circle({ atome_id: :the_circle })
c.text({ content: "children are restored too!!", visual: 22 })

b = box({ x: 666, drag: true, atome_id: :the_box })
t = b.text({ content: :ok, yy: 3, color: :black , atome_id: :the_text})
i = image({ content: :atome, size: 33, x: 96 })

i.transfer(b.atome_id)
t.content("logo parent is #{i.parent}")

c.touch do
  grab(:view).extract(c.atome_id)
  grab(:the_box).extract(i.atome_id)
  grab(:view).insert(i.atome_id)
  ATOME.wait 2 do
    grab(:intuition).insert(c.atome_id)
  end
  c.touch do
    c.delete
  end
end