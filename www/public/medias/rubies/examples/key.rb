# key

b=box({color: :orange, atome_id: :the_box})
t=text({content: "type some text over the box, \n touch the circle to stop the input capture \n ", x:96, y: 20})
b.key(options: :press) do |key|
  t.content(key.key_code)
end
c=circle
c.x=c.y=96
c.touch do
  b.key(options: :stop)
end

c2=circle({width: 300,y: 300, color: :orange})
t2=c2.text({content: "Here key will be captured on key up!", color: :black, x: 3, y: 15 , center: true})
c2.key({options: :up}) do |evt|
  t2.content(evt.key_code)
  t2.center(true)
end