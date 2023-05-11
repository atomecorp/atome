# frozen_string_literal: true

t = text({ data: "hit the box to make me editable" })

b = box({ left: 333 })
b.touch(true) do
  if t.edit.value == true
    t.edit(false)
  else
    t.edit(true)
  end
end
