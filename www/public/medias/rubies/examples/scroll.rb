# Scroll

t = text({content: "drag the circle out the window", x: 66, fixed: true})
c = circle({x: 96, y: 96})
c.drag(true)

grab(:view).scroll_html do
  t.content("x position : #{c.x}, y position : #{c.y}")
end