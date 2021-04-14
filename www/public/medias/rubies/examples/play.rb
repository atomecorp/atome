# play videos

v=video({atome_id: :the_video, atome_id: :the_video,shadow: {blur: 6 , thickness: 1, x: 3, y:3, color: :black}, drag: true})
v.touch do
  v.play(true)
end