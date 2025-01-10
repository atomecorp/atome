# atomiser example

b = box({ x: 99, y: 99 })
t2 = text({ content: "first touch me to change color property to red, and smooth", x: 33, y: 33, width: :auto })
t3 = text({ content: "then touch me to render the changes", x: 33, y: 66, width: :auto })
t2.touch do
  b.atomiser({ color: :red })
  b.atomiser({ smooth: 6 })
end

t3.touch do
  b.render(true)
end

