# Scroll

t = text({content: "drag the circle out the window",width: 396, x: 66, position: :fixed})
c = circle({x: 96, y: 96})
c.drag(true)

grab(:view).scroll_html do |evt|
  t.content("x position : #{c.x}, y position : #{c.y}")
end