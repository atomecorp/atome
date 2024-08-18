# frozen_string_literal: true

# please note that whatever the atome resize will return the size of the view!
view = grab(:view)
view.on(:resize) do |event|
  puts "view size is #{event}"
end

b=box
b.touch(true) do
  view.on(:remove)
end


c=circle({ left: 333 })

c.touch(true) do
  view.on(:resize) do |event|
    puts "Now size is : #{event}"
  end
end