# frozen_string_literal: true

# frozen_string_literal: true

# puts 'type you problematic code here!'
col=color({green: 1, id: :the_col})

b=box({top: 3})
t=text(data: :red, left: 0, top: 123)
t1=text(data: :green, left: 100, top: 123)
t2=text(data: :blue, left: 200, top: 123)
t3=text(data: :yellow, left: 300, top: 123)
t4=text(data: :orange, left: 400, top: 123)
t5=text(data: :cyan, left: 500, top: 123)

item_to_batch=[t.id,t1.id,t2.id, t3.id, t4.id, t5.id]
the_group= group({ collect: item_to_batch })
the_group.apply([:the_col])
t.touch(true) do
  b.color({id: :red, red: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t1.touch(true) do
  b.color({id: :green, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t2.touch(true) do
  b.color({id: :blue, blue: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t3.touch(true) do
  b.color({id: :yellow,  red: 1, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t4.touch(true) do
  b.color({id: :orange,  red: 1, green: 0.5 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t5.touch(true) do
  b.color({id: :cyan,  blue: 1, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end

t=text({data: "dynamic color propagation, touch me to propagate"})
t.apply(:the_col)
c=circle({id: :the_circle, top: 260})
c.apply([:the_col])
b.apply([:the_col])

t.touch(true) do
  col.red(1)
end


