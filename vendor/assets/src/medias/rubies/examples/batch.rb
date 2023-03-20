# frozen_string_literal: true
# batch
b=box({ id: :b1 })
box({ id: :b2, left: 220 })
box({ id: :b3, left: 340 })
b.batch([:b1, :b2])
# puts "----- batch ------"
# puts "=> the batch found is #{a}"
# p a.batch.value
b.batch.color(:red).top(0).rotate(33)

b.batch.each do |el|
  el.height(77).blur(9)
end