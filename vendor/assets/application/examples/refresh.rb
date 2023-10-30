# frozen_string_literal: true

b = box({ top: 166 })
c=color({ id: :col1, red: 1, blue: 1, affect: [:view]})
b.instance_variable_set("@left", 300)
b.instance_variable_set("@width", 150)
b.instance_variable_set("@apply", [c.id])
b.instance_variable_set("@smooth", 9)

wait 1 do
  b.refresh
end
