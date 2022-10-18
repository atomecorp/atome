# Reboot

button=box({height: 33, x: 9, width: 222, smooth: 33, y: 6})
button.text({content:  "Reboot", x: 6 })

b=box({x: 99, y: 99})
b.drag(true)
b.touch do
  color(:red)
  v=video(:madmax)
  v.play(true)
end
button.touch do
  grab(:view).reboot
end
