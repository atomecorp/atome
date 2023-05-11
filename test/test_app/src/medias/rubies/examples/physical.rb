# frozen_string_literal: true

b = box({left: 333, id: :the_one_box})
b.color(:red)

b.circle({top: 66, id: :the_circle, color: :green})
b.box({left: 166,top: 166, id: :the_box, color: :green})
b.text({left: 166, id: :the_text, data: :green})
b.image('red_planet.png')
`console.clear()`
puts "b: #{b}"



wait 2 do
  b.physical.each do |attached_atome_id|
    b.delete({id: attached_atome_id})
  end
end