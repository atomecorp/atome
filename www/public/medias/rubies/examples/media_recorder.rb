camera({atome_id: :camera_id, width: 777,height: 333, x: 33, y: 333,  shadow: {blur: 6 , thickness: 1, x: 3, y:3, color: :black}})
b = box({ x: 200, y: 200, color: :white })
t1=b.text('Stop')
c = circle({ y: 200, color: :pink })
t=c.text('Rec')
c.touch do
  b.color(:white)
  c.color(:red)
  t.content("recording")
  t1.content(:stop)
  `
    recorderHelper.startRecording()
  `
end
b.touch do
  b.color(:black)
  c.color(:pink)
  t.content(:stop)
  t1.content(:stopped)

  `
    recorderHelper.stopRecording()
  `
end