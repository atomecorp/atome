# frozen_string_literal: true
# batch
b=box({ id: :b1 })
b.box({ id: :b2, left: 220 })
b.box({ id: :b3, left: 340 })
b.batch([:b2, :b3])
batched_object= b.batch
puts batched_object
# puts "----- batch ------"
# puts "=> the batch found is #{a}"
# p a.batch.value
batched_object.color(:red).rotate(33)
batched_object.each do |el|
  el.height(77).blur(9)
end
wait 1 do
 batched_object.top(0)
end

