# atomiser example

b = box({x: 220, y: 50})
t2 = text({content: "change color property to red, and smooth the box ", x: 33,y: 33})
t3 = text({content: "render the change", x: 33,y: 66})
t2.touch do
  b.atomiser({ color: :red })
  b.atomiser({ smooth: 6})
end

t3.touch do
  b.render(true)
end

