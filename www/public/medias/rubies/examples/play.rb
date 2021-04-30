# play videos
button=circle({size: 33})
button.text("fullscreen")
v=video({atome_id: :the_video, shadow: {blur: 6 , thickness: 1, x: 0, y:0, color: :black}, scale: true,drag: true})
v.touch do
  v.play(true)
end

button.touch do
  v.size(grab(:view).convert(:width))
  v.x(0)
  v.y(0)
end