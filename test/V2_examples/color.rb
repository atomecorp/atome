# frozen_string_literal: true

# FIXME: bug we using a color twice or more only the first is colored: c = { red: 1 }; a.color(c),b.color(c)

c = circle

wait 1 do
  # the most performant way :
  # please note that in this case:  render , id and type params must place in order
  c.color(
    { renderers: [:browser], id: :c319, type: :color,
      red: 1, green: 1, blue: 0.15, alpha: 0.6 }
  )
  puts c
end

wait 2 do
  # now we overload the color
  c.color({ red: 1 })
  puts c

end

wait 4 do
  # now the easy way
  c.color(:yellow)
  puts c

  wait 1 do
    c.color({ green: 1, blue: 0.69, alpha: 1 })
    puts c

  end
end

wait 5 do
  d=c.color(:red)
  puts c

  wait 1 do
    d.blue(0)
    puts c

  end

  wait 2 do
    d.red(1)
    puts c

  end
end


wait 10  do
  d=Atome.new({ color: { renderers: [:browser], id: :col1, type: :color,  attach: [],attached: [],
                       left: 33, top: 66, red: 1, green: 0.15, blue: 0.7, alpha: 1 } })

  col_2 = Atome.new({ color: { renderers: [:browser], id: :col2, type: :color, attach: [],attached: [],
                               left: 33, top: 66, red: 0, green: 0.15, blue: 0.7, alpha: 1 } })

  puts d
  e=Atome.new(
    shape: { type: :shape, renderers: [:browser], id: :shaped, attach: [:view],  attached: [:col1],
             left: 199, top: 99,
             width: 66, height: 66
    }
  )
  puts e
  wait 2 do
    col_2.attach([:shaped])
    puts e
  end
end
