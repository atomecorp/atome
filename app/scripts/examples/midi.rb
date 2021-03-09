# midi

cc = circle({width: 33, height: 33, y: 66, x: 69, color: :yellow, atome_id: :the_cc})
cc2 = circle({width: 33, height: 33, y: 66, x: 33, color: :yellow, atome_id: :the_cc})
cc.touch({option: :down}) do
  cc.transmit({midi: {play: {note: "C3", channel: 15, velocity: 10}}})
end

cc.touch({option: :up}) do
  cc.transmit({midi: {stop: {note: "C3", channel: 15, velocity: 100}}})
end

cc2.touch({option: :down}) do
  cc.transmit({midi: {play: {note: "E3", channel: 15, velocity: 10}}})
end

cc2.touch({option: :up}) do
  cc.transmit({midi: {stop: {note: "E3", channel: 15, velocity: 100}}})
end