# Add example

hh = box({ name: :home, x: 99, y: 9, color: :black })
hh.text({ visual: 12, content: "touch the box" })
hh.touch do
  # this will  not be trig if it works correctly
  alert :kool
end
hh.touch (:remove)
hh.touch do
  hh.width = hh.width + 9
end
hh.add({ touch: { proc: lambda do
  self.color(:darkred)
end } })

hh.add(:touch) do
  wait 1 do
    self.color(:white)
    # hh.delete(true)
  end

  wait 2 do
    color :orange
  end
end
