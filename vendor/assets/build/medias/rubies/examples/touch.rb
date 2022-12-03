# frozen_string_literal: true

separator=120
b=box({ left: separator })
c=box({ left: b.left.value+separator })
d=box({ left: c.left.value+separator })
e=box({ left: d.left.value+separator })

b.touch(:down) do
  b.color(:red)
  c.color(:red)
  d.color(:red)
  e.color(:red)
end
b.text({data: :down})

c.touch(:long) do
  b.color(:blue)
  c.color(:blue)
  d.color(:blue)
  e.color(:blue)
end
c.text({data: :long})

d.touch(:up) do
  b.color(:yellow)
  c.color(:yellow)
  d.color(:yellow)
  e.color(:yellow)
end
d.text({data: :up})
e.touch(:double) do
  b.color(:black)
  c.color(:black)
  d.color(:black)
  e.color(:black)
end
e.text({data: :double})