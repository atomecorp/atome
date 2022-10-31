c = circle()

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

