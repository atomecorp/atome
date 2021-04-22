camera({atome_id: :camera_id, width: 666,height: 96, x: 333, y: 333, size: 300, shadow: {blur: 6 , thickness: 1, x: 3, y:3, color: :black}})
c = circle(y: 200)
c.text('Rec')
c.touch do
  `
    recorderHelper.startRecording()
  `
end
b = box(x: 200, y: 200)
b.text('Stop')
b.touch do
  `
    recorderHelper.stopRecording()
  `
end