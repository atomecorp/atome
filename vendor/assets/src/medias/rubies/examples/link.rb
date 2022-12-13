# frozen_string_literal: true

text = Atome.new(
  text: { renderers: [:browser], id: :my_text, type: :text, parents: [:view], children: [], visual: { size: 18 },
          data: 'My first text!', left: 300, top: 33, width: 199, height: 33,
          color: { renderers: [:browser], id: :c31, type: :color, parents: [:my_text], children: [],
                   red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
  }
)

Atome.new({ color: { renderers: [:browser], id: :new_col, type: :color, parents: [], children: [],
                     left: 33, top: 66, red: 0, green: 0.15, blue: 0.7, alpha: 0.6 } })

# now we change the color all the object that share the care modified
wait 1 do
  text.link(:new_col)
end
wait 2 do
  grab(:new_col).red(1)
end