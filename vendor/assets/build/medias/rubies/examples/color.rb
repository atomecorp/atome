c = circle()
# FIXME: bug we creating an object like this c = circle({ red: 1 })
# FIXME: bug we using a color twice or more only the first is colored: c = { red: 1 }; a.color(c),b.color(c)
# Example:
# c={ red: 1 }
# a=circle
# b=box({ left: 300 })
# a.color(c)
# b.color(c)
wait 1 do
  # the most performant way :
  # please note that in this case:  render , id and type params must place in order
  c.color(
    { render: [:html], id: :c319, type: :color,
      red: 1, green: 1, blue: 0.15, alpha: 0.6 }
  )
end

wait 2 do
  # now we overload the color
  c.color({ red: 1 })
end

wait 4 do
  # now the easy way
  c.color(:yellow)
end

