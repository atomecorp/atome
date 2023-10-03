# border demos

b = box({ x: 33, y: 33, text: "touch me!" })

b.border({ color: :red, thickness: 3, pattern: :dashed })

b.touch do
  b.border({ color: :orange, thickness: 7, pattern: :solid })
end