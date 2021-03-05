# repeat

b=box({x:300, y: 33})
t=text("click me to kill the wait process")
poil= ATOME.repeat 0.02, 300 do |evt|
  b.x(evt)
  b.smooth(evt/10)
end
t.touch do
  ATOME.clear({repeat: poil})
end
