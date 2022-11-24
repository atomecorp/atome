# frozen_string_literal: true

c = circle
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
  wait 1 do
    c.color({ green: 1, blue: 0.69, alpha: 1 })
  end
end

wait 5 do
  d=c.color(:red)
  wait 1 do
    d.blue(0)
  end

  wait 2 do
    d.red(1)
  end
end

circle({id: :the_circle})


wait 2 do
  the_col=Atome.new({ color: { renderers: [:browser], id: :c31, type: :color, parents: [], children: [],
                               left: 33, top: 66, red: 0, green: 0.15, blue: 0.7, alpha: 0.6 } })
  the_col.parents([:the_circle])
end