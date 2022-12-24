# frozen_string_literal: true

a = box({ width: 333, height: 333, id: :the_boxy })
a.color(:red)
b = box({ width: 33, height: 33, id: :the_box, drag: true })
b.parents([a.id.value])
b.color(:black)
# b.parents([:the_boxy ])
b.drag({ move: true }) do |e|
  puts e
end

# b.drag({ move: false}) do |e|
#   puts e
# end


b.drag({ start: true}) do |e|
  b.color(:yellow)
end

b.drag({ end: true}) do |e|
  b.color(:orange)
end

# b.drag({ inertia: true })

# b.drag({ lock: :start })

b.drag({ lock: :x })

# b.drag({ remove: true })
# b.drag({ remove: false })


# b.drag({ constraint: { top: 330, left: 30, bottom: 30, right: 1 } })
b.drag({ constraint: :parent })
b.drag({ snap: { x: 100, y: 190 } })

# b.drag({ constraint: :the_boxy })