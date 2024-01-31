# frozen_string_literal: true


c = circle({ height: 400, width: 200, top: 100, left:99, top: 79 })
b = c.box({ width: 200, height: 100, left: 280, top: 190, id: :my_box })
i= image(:red_planet)
c.touch(true) do
  c.fit({ value: 100, axis: :x })
end

puts '------'
puts "b.compute  left return the position on the screen of the item : #{b.compute({reference: c.id, particle: :left, metrics: :pixel})}"
puts "b.compute left : #{b.compute({ particle: :left })[:value]}, c left : #{b.left}"
puts "b.compute top :#{b.compute({ particle: :top })[:value]}, c top: #{b.top}"
puts  "i.compute width :#{i.compute({ particle: :width })[:value]}, i width: #{i.width}"
puts "i.compute height :#{i.compute({ particle: :height })[:value]}, i height: #{i.height}"
