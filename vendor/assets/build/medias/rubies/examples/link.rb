text = Atome.new(
  text: { render: [:html], id: :text1, type: :text, parent: [:view], visual: { size: 33 }, data: "My text!", left: 300, top: 33, width: 199, height: 33, }
)

# now we change the color all the object that share the care modified
wait 1 do
  text.text.link(:c315)
end
wait 2 do
  grab(:c315).red(0)
end