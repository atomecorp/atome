# play videos

button=box({height: 33, x: 9, width: 222, smooth: 33, y: 6})
button.text({content:  "full screen", x: 6 })

button2=box({height: 33, x: 9, width: 222, smooth: 33, y: 66})
button2.text({content:  "full page", x: 6 })


v=video({drag: true,atome_id: :the_video, shadow: {blur: 6 , thickness: 1, x: 0, y:0, color: :black}, scale: true, x: 333, y: 150})
v.touch do
  v.play(true)
  v.size(666)
end

button.touch do
  v.fullscreen(true)
end

button2.touch do
  v.size(grab(:view).convert(:width))
  v.x(0)
  v.y(0)
end
