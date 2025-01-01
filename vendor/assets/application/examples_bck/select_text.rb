#  frozen_string_literal: true

new({particle: :select})
t = text :hello
t.left(99)

t.edit(true)

b=box
b.touch(true) do
  puts t.data
  back_color = grab(:back_selection)
  text_color = grab(:text_selection)
  back_color.red(1)
  back_color.alpha(1)
  text_color.green(1)
  t.component({ selected: true })
end