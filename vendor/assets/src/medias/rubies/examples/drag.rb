# frozen_string_literal: true

a = box({ width: 333, height: 333, id: :the_boxy })

a.drag(move: false) do |event|
  puts "the pointer is at : #{event}"

end
a.color(:red)
b = circle({ width: 33, height: 33, id: :the_box, drag: true })


b.parents([a.id])
b.color(:black)
# b.parents([:the_boxy ])
b.drag({ move: true }) do |e|
  puts e
end

# b.drag({ move: false}) do |e|
#   puts e
# end


b.drag({ start: true}) do |e|
  b.color(:yellow)
end

b.drag({ end: true}) do |e|
  b.color(:orange)
end

# b.drag({ inertia: true })

# b.drag({ lock: :start })

b.drag({ lock: :x })

# b.drag({ remove: true })
# b.drag({ remove: false })


# b.drag({ constraint: { top: 330, left: 30, bottom: 30, right: 1 } })
b.drag({ constraint: :parent })
b.drag({ snap: { x: 100, y: 190 } })

# b.drag({ constraint: :the_boxy })

cc=circle(drag: true)
cc.drag(true) do |ee|
  puts "the circle  is : >#{cc.left} : #{ee}"

end

cc.drag(:end) do |ee|
  puts "the circle  is ending drag : >#{cc.left} : #{ee}"
end


cc.drag(:start) do |ee|
  puts "==> the circle is starting drag : >#{cc.left} : #{ee}"
end




cc.touch(true) do
  # alert cc.left
  puts "===>ee is : >#{cc.left}"
end

bb=box({drag: true, color: :yellow})

bb.attach(cc.id)

# alert"#{b.parents.class} :  #{b.parents}"
a.touch(true) do
  puts cc.left
end


# Sticky box
sticky_box=box({left: 633})
sticky_box.text("my position will be reverted")
start_x_pos=sticky_box.left
start_y_pos=sticky_box.top
sticky_box.drag(move: true) do
  puts sticky_box.left
end
sticky_box.drag(:start) do
  puts "start => #{sticky_box.left} : #{sticky_box.top}"
end

sticky_box.drag(:end) do
  puts "end => #{sticky_box.left} : #{sticky_box.top}"
  sticky_box.left(start_x_pos)
  sticky_box.top(start_y_pos)
end
