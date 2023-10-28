#  frozen_string_literal: true

t = text :hello
t.left(99)

t.edit(true)

b=box
b.touch(true) do
  puts t.data
end