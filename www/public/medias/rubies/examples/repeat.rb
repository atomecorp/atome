# repeat

b=box({x:300, y: 33})
t=text({content: "click me to kill the repeat process", width: 33})
countdown=text("")
countdown.y(66)
repeater= ATOME.repeat 0.1, 300 do |evt|
  b.x(evt)
  b.smooth(evt/10)
  b.color({red: -(evt-300)/100/3})
  content=-(evt-300)/100/3
  countdown.content(content)
end
t.touch do
  ATOME.clear({repeat: repeater})
end
