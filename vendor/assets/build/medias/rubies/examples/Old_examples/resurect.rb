# resurrect example

hh = grab(:view).tool({ name: :home, x: 99, y: 9, color: :black })
hh.add({ touch: {  proc: lambda do
  self.color(:darkred)
end } })

hh.add(:touch) do
  wait 2 do
    self.color(:white)
    hh.delete(true)
  end

  wait 3 do
    resurrect :home_tool
  end
end


b = box({color: :green, x: 200, y: 100, atome_id: :the_box, drag: true })
t = b.text({ content: "click the box or the tool to delete, it'll be resurected!", y: 99, x: 33,  atome_id: :the_text })
b.image({ content: :moto, x: 150, y: 9, size: 66, atome_id: :the_image })
t.circle({ x: 33, y: -99, size: 66, atome_id: :the_circle })

b.touch do
  b.delete(true)
  ATOME.wait 1 do
    resurrect b.atome_id
  end
end