# play audio example

a=audio({content: :snare,  x: 0, y: 250, atome_id: :snare, color: :pink, width: 333, height: 33,})
a.touch(option: :down) do
  a.play(true)
end