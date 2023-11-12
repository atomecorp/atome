#  frozen_string_literal: true

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })

t=text({id: :the_text, data: 'type of touch : ?'})

t.touch(:down) do
  b.touch({remove: :down})
   # b.touch(:remove) # or  b.touch(false) to remove all touches bindings
  t.data('touch down killed')
end
b.touch(true) do
  # t.data('type of touch : ?')
  b.color(:red)
  puts 'box tapped'
end

b.touch(:long) do
  t.data('type of touch is : long ')
  b.color(:black)
end

b.touch(:up) do

  t.data('type of touch is : up ')
  b.color(:orange)
end

b.touch(:down) do
  t.data('type of touch is : down ')
  b.color(:white)
end

b.touch(:double) do
  t.color(:red)
  t.data('type of touch is : double ')
  b.color(:yellowgreen)
end
