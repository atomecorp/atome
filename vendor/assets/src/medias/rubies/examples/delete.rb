# frozen_string_literal: true

# b = box({left: 333, id: :the_box_1})
# b.color({id: :the_orange_col, red: 1, blue: 0.5})
# b.circle({top: 66, id: :the_circle_1, color: :yellow})
#
#
# wait 2 do
#   b.delete(:left)
# end
# #
# wait 3 do
#   b.shape.each do |attached_atome_id|
#     # b.delete({id: attached_atome_id.id})
#     attached_atome_id.delete(true)
#   end
#
# end
#
#
# wait 4 do
#   b.delete(:color)
# end




# recursive example
bb=box({id: :the_box})
bb.text({id: :text_0, data: 'click me!'})
col=color({ id: :col_1, red: 1, green: 0.5 })
bb.touch(true) do
  bb.box({attached: col.id})
  c=bb.circle(({ id: :circle_1 }))
  c.text({id: :text_1, data: :hello})
  # alert bb
  tot=[]
  Universe.atomes.each do |k,v|
    tot << k
  end
  puts "before: #{tot}"
  wait 1 do
    bb.physical.each do |attached_atome_id|
      puts "==> delete : #{attached_atome_id.id}"
      bb.delete({id: attached_atome_id.id, recursive: true})
    end
    tot=[]
    Universe.atomes.each do |k,v|
      tot << k
    end
    puts "after: #{tot}"
  end
  puts  Universe.atomes.length
end

