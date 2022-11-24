# frozen_string_literal: true

text = Atome.new(
  text: { renderers: [:browser], id: :text1, type: :text, parents: [:view], children: [], visual: { size: 18 },
          data: 'My first text!', left: 300, top: 33, width: 199, height: 33,
          color: { renderers: [:browser], id: :c31, type: :color, parents: [:text1], children: [],
                   red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
  }
)

# now we change the color all the object that share the care modified
wait 1 do
  text.link(:c315)
end
wait 2 do
  grab(:c315).red(0)
end