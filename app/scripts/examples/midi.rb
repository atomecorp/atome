# midi

cc=circle({width: 69, height: 69, y: 66, x: 69, color: :yellow})

cc.touch do
  cc.midi_verif("verifdone")
end