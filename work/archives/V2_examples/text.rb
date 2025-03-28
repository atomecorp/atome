# frozen_string_literal: true

my_text = Atome.new(
  text: { renderers: [:browser], id: :text1, type: :text, attach: [:view], visual: { size: 33 },
          data: 'My first text!', left: 120, top: 33, width: 199, height: 33,fasten: [],

  }
)

Atome.new(color: { renderers: [:browser], id: :c31, type: :color, attach: [:text1],
                   red: 0.6, green: 0.6, blue: 0.6, alpha: 1 ,fasten: []})

wait 1 do
  my_text.data(:kool)
end

text({ id: :the_text, left: 0 })

text2=Atome.new(
  text: { renderers: [:browser], id: :text2, type: :text, attach: [:view], visual: { size: 33 },
          data: 'My second text!', left: 333, top: 33, width: 199, height: 33,fasten: [],

  }
)

Atome.new(color: { renderers: [:browser], id: :c33, type: :color, attach: [:text2],fasten: [],
                   red: 0.6, green: 0.6, blue: 0.1, alpha: 1 })
wait 2 do
  text2.data(:ok)
end

b = box({ left: 66, top: 66, drag: true })
my_text = b.text({ data: 'drag the bloc behind me', width: 333, left: 55 })
wait 3 do
  my_text.color(:red)
end

