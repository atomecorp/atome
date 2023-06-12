# frozen_string_literal: true

b = box({left: 333, id: :the_one_box})
b.color(:red)

b.circle({top: 66, id: :the_circle, color: :green})
b.box({left: 166,top: 166, id: :the_box, color: :green})
b.text({left: 166, id: :the_text, data: :green})
b.image('red_planet.png')

wait 1 do
  b.physical.each do |attached_atome_id|
    puts attached_atome_id
    grab(attached_atome_id).width(55)
  end
end

wait 2 do
  b.physical.each do |attached_atome_id|
    grab(attached_atome_id).delete(true)
  end
end

# wait 2 do
#   b.delete(:physical)
#   puts "b is : #{b}"
# end

# # the physical method is used to retrieve or delete all children with a visual rendering
# # but leave alone other atome such as color
# b = box
# cc2 = color(:yellow)
# b.color(:red)
# c = b.circle
# c.attached(cc2.id)
# b.text(:hello)
# b.add(text: { data: :ok, left: 133 })
# wait 2 do
#   b.delete(:physical)
#   puts "b is : #{b}"
# end
