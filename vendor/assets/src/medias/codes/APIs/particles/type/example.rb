# frozen_string_literal: true

b = box({ top: 166, data: :hello,path: './medias/images/red_planet.png'  })
b.color({ id: :col1, red: 1, blue: 1})

# b.instance_variable_set("@top", 30)
# b.instance_variable_set("@apply", [c.id])
# b.instance_variable_set("@path",  )

# b.instance_variable_set("@smooth", 30)
wait 1 do
  b.type=:text
  b.refresh
  wait 1 do
    b.type=:image
    b.refresh
  end
end