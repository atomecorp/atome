# Fullscreen

button3=box({height: 33, x: 9, width: 222, smooth: 33, y: 6})
button3.text({content:  "back to normal", x: 6 })

button=box({height: 33, x: 9, width: 222, smooth: 33, y: 66})
button.text({content:  "image fullscreen", x: 6 })

button2=box({height: 33, x: 9, width: 222, smooth: 33, y: 120})
button2.text({content:  "page fullscreen", x: 6 })


img=image({ content: :moto, x: 222, y: 222 })

button.touch do
  img.fullscreen(true)
end

button2.touch do
  grab(:view).fullscreen(:all)
end

circle({x:333})
box({x:333, y: 99})
text({content: :hello, visual: 99, x: 666, y: 66})
batch([button3, img]).touch do
  grab(:view).fullscreen(false)
end