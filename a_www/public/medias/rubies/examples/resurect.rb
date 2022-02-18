# resurect example
b = box({ atome_id: :my_atome, color: :green, x: 200, y: 100, atome_id: :the_box, drag: true })
t = b.text({ content: "click the box to delete, it'll be resurected!", y: 99, x: 33, atome_id: :the_child, atome_id: :the_text })
b.image({ content: :moto, x: 150, y: 9, size: 66, atome_id: :the_image })
t.circle({ x: 33, y: -99, size: 66, atome_id: :the_circle })



b.touch do
  b.delete(true)
  ATOME.wait 1 do
    resurrect b.atome_id
  end
end
