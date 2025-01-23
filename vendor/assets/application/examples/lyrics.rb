#  frozen_string_literal: true

b=box({width: 33, height: 19, color: :red})
b.text(data: :start, component: {size: 9}, top: -12, left: 3)
b1=box({width: 33, height: 19, color: :green, left: 39})
b1.text(data: 'start reset', component: {size: 9}, top: -6, left: 3)


b2=box({width: 33, height: 19, color: :blue, left: 125})
b2.text(data: :stop, component: {size: 9}, top: -12, left: 3)
b3=box({width: 33, height: 19, color: :orange, left: 160})
b3.text(data: :pause, component: {size: 9}, top: -12, left: 3, color: :black)

b4=box({left: 120, top: 70, color: :purple})


t=text({data:  :counter, left: 60, top: 90, position: :absolute })
t2=b4.text(data: :verif, component: {size: 9}, top: -12, left: 3)
t3=text({data: :lyrics, edit: true,component: {size: 16}, top: 190, left: 35, position: :absolute})

b4.touch(true) do
  t2.data(t.timer[:position])
end
t.timer({position: 88})

b.touch(true) do
  t.timer({  end: 3000 }) do |val|
    t.data(val)
    t.timer[:position]=val
  end
end

b1.touch(true) do
  t.timer({  end: 3000, start: 0 }) do |val|
    puts val
    t.timer[:position]=val
  end
end

b2.touch(true) do
  t.timer({ stop: true})
end
b3.touch(true) do
  t.timer({ pause: true})
end




