# frozen_string_literal: true

# frozen_string_literal: true

# puts 'type you problematic code here!'

b=box({top: 3})
t=text(data: :red, left: 0, top: 123)
t1=text(data: :green, left: 100, top: 123)
t2=text(data: :blue, left: 200, top: 123)
t3=text(data: :yellow, left: 300, top: 123)
t4=text(data: :orange, left: 400, top: 123)
t5=text(data: :cyan, left: 500, top: 123)
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
