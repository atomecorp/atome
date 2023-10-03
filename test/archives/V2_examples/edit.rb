# frozen_string_literal: true

t = text({ data: "hit the box to make me editable" })
# alert t.class
b = box({ left: 333 })
t.left(234)
# alert t.left
# c=image("red_planet.png")
# alert c.class
# c.left(400)
b.touch(true) do
  puts Universe.atomes.length
  if t.edit == true
    t.color(:red)
    t.edit(false)
  else
    puts "off #{t}: #{t.class}"
    t.color(:blue)
    t.edit(true)
  end
end

a="hello         "
a=a.chomp
a=a.rstrip



