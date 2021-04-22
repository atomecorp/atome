# play videos

v=video({atome_id: :the_video, shadow: {blur: 6 , thickness: 1, x: 0, y:0, color: :black}, drag: true})
v.touch do
  v.play(true)
end