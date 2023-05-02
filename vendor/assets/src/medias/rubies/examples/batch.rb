# frozen_string_literal: true
# batch
b=box({ id: :b1 })
b.box({ id: :b2, left: 220 })
b.box({ id: :b3, left: 340 })
b.batch([:b2, :b3])
# puts "----- batch ------"
# puts "=> the batch found is #{a}"
# p a.batch.value
b.batch.color(:red).rotate(33)
b.batch.each do |el|
  el.height(77).blur(9)
end
wait 1 do
  puts b.batch.top(0)
end

