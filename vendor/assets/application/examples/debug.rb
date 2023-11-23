# frozen_string_literal: true

# puts 'type you problematic code here!'

b=box({id: :my_box})
# b.circle
col=b.color(:red)
wait 1 do
  puts "attach : =====> #{b.attach}"
  puts "apply : =====> #{b.apply}"
  puts "affect: =====> #{b.affect}"
  puts "attached : =====> #{b.attached}"
end



