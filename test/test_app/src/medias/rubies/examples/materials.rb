# frozen_string_literal: true

# the materials method is used to retrieve or delete all children with a visual rendering
# but leave alone other atome such as color
b = box
cc2 = color(:yellow)
b.color(:red)
c = b.circle
c.attached(cc2.id)
b.text(:hello)
b.add(text: { data: :ok, left: 133 })
wait 2 do
  b.delete(:materials)
  puts "b is : #{b}"
end
