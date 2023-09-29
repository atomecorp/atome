# midi example

c = circle({ width: 33, height: 33, y: 33, x: 33, color: :black, atome_id: :the_c2 })
c2 = circle({ width: 33, height: 33, y: 33, x: 69, color: :red, atome_id: :the_c })
t = text({ content: "", x: 33, y: 96, width: 333 })
c.touch do
  interfaces = c.transmit({ midi: :inputs })
  t.content(interfaces.join("\n"))
end
c2.touch do
  interfaces = c.transmit({ midi: :outputs })
  t.content(interfaces.join("\n"))
end
cc = circle({ width: 33, height: 33, y: 69, x: 69, color: :yellow, atome_id: :the_cc })
cc2 = circle({ width: 33, height: 33, y: 69, x: 33, color: :yellow, atome_id: :the_cc2 })
cc3 = circle({ width: 33, height: 33, y: 96, x: 69, color: :green, atome_id: :the_cc3 })

cc.touch({ option: :down }) do
  cc.transmit({ midi: { play: { note: "C3", channel: 15, velocity: 10 } } })
end

cc.touch({ option: :up }) do
  cc.transmit({ midi: { stop: { note: "C3", channel: 15, velocity: 100 } } })
end

cc2.touch({ option: :down }) do
  cc.transmit({ midi: { play: { note: "E3", channel: 15, velocity: 10 } } })
end

cc2.touch({ option: :up }) do
  cc.transmit({ midi: { stop: { note: "E3", channel: 15, velocity: 100 } } })
end

cc3.touch({ option: :down }) do
  cc.transmit({ midi: { control: { controller: 33, value: 15 } } })
end