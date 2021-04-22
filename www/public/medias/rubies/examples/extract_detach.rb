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
grab(:device).color({red: 0.4})