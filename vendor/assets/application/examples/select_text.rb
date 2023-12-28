#  frozen_string_literal: true

new({particle: :select})
t = text :hello
t.left(99)

t.edit(true)

b=box
b.touch(true) do
  puts t.data
  t.component({ selected: {color: :orange, text: :black} })
end