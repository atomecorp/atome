c = circle

# the easy way
c.color(:red)

# the most performant way :

c.color(
  { render: [:html], id: :c319, type: :color,
    red: 1, green: 1, blue: 0.15, alpha: 0.6 }
)

# please note that render , id and type params must place in order